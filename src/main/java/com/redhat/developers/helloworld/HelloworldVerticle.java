/**
 * JBoss, Home of Professional Open Source
 * Copyright 2016, Red Hat, Inc. and/or its affiliates, and individual
 * contributors by the @authors tag. See the copyright.txt in the
 * distribution for a full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.redhat.developers.helloworld;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.text.StrSubstitutor;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.http.HttpMethod;
import io.vertx.core.json.JsonArray;
import io.vertx.core.json.JsonObject;
import io.vertx.core.logging.Logger;
import io.vertx.core.logging.LoggerFactory;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;
import io.vertx.ext.web.handler.CorsHandler;
import io.vertx.mysqlclient.MySQLConnectOptions;
import io.vertx.mysqlclient.MySQLPool;
import io.vertx.sqlclient.PoolOptions;
import io.vertx.sqlclient.Row;
import io.vertx.sqlclient.RowSet;

public class HelloworldVerticle extends AbstractVerticle {

    public static final String version = "1.0";
    private Logger logger = LoggerFactory.getLogger(HelloworldVerticle.class);

    @Override
    public void start() throws Exception {
        Router router = Router.router(vertx);

        // Config CORS
        router.route().handler(CorsHandler.create("*").allowedMethod(HttpMethod.GET).allowedHeader("Content-Type"));

        // Database endpoint
        router.get("/api/db").handler(ctx -> {
            logger.info("Reading records from the database");
            readFromDatabase(ctx);
        });

        // hello endpoint
        router.get("/api/hello/:name").handler(ctx -> {
            String helloMsg = hello(ctx.request().getParam("name"));
            logger.info("New request from " + ctx.request().getHeader("User-Agent") + "\nSaying...: " + helloMsg);
            ctx.response().end(helloMsg);
        });

        // health check endpoint
        router.get("/api/health").handler(ctx -> {
            ctx.response().end("I'm ok");
        });
        vertx.createHttpServer().requestHandler(router).listen(8080);
    }

    private void readFromDatabase(RoutingContext ctx) {
        JsonObject config = ApplicationConfiguration.load(config());
        System.out.println(config);
        MySQLConnectOptions connectOptions = new MySQLConnectOptions()
                .setPort(config.getInteger("port") == null? 3306 : config.getInteger("port"))
                .setHost(config.getString("host"))
                .setDatabase(config.getString("database"))
                .setUser(config.getString("username"))
                .setPassword(config.getString("password"));
        System.out.println(config.getString("password"));
        // Pool options
        PoolOptions poolOptions = new PoolOptions().setMaxSize(5);
        System.out.println("pool options");
        // Create the client pool
        MySQLPool client = MySQLPool.pool(vertx, connectOptions, poolOptions);
        System.out.println("client options");
        client.query("SELECT name FROM mytable").execute(ar -> {
            if (ar.succeeded()) {
              RowSet<Row> rowSet = ar.result();
              logger.info("Got " + rowSet.size() + " rows ");
              JsonArray jsonArray = new JsonArray();
              for (Row row: rowSet){
                  jsonArray.add(row.getString("name"));
              }
              
              ctx.response().end(jsonArray.toString());
            } else {
                ctx.response().end("Error executing the query. Check the logs");
                ar.cause().printStackTrace();
            }
          
            // Now close the pool
            client.close();
        });
    }

    private String hello(String name) {
        String configGreeting = ApplicationConfiguration.load(config()).getString("GREETING");
        String greeting = configGreeting == null ? "Hello {name} from {hostname} with {version}" : configGreeting;
        Map<String, String> values = new HashMap<String, String>();
        values.put("name", name);
        values.put("hostname", System.getenv().getOrDefault("HOSTNAME", "unknown"));
        values.put("version", version);
        return new StrSubstitutor(values, "{", "}").replace(greeting);
    }

}
