package com.redcarpetup.springboothelloworld;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringbootHelloworldApplication {

	@ClassRule
	public static PostgreSQLContainer postgres = new PostgreSQLContainer();

	@BeforeClass
	public static void startDb() {
		postgres.start();
	}

	public static void main(String[] args) {
		SpringApplication.run(SpringbootHelloworldApplication.class, args);
	}

	@AfterClass
	public static void stopDb() {
  		postgres.stop();
	}

}

