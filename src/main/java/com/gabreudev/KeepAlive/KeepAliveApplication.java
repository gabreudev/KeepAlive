package com.gabreudev.KeepAlive;

import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import java.io.IOException;

@SpringBootApplication
@EnableScheduling
public class KeepAliveApplication {

	private static final OkHttpClient client = new OkHttpClient();
	@Value( "${API_URL}")
	private String API_URL;
	private static final Long timeInMilliseconds = 30000L; //  5 Minutos


	public static void main(String[] args) {
		SpringApplication.run(KeepAliveApplication.class, args);
	}
	@Scheduled(fixedRate = 60000)
	public void pingApi() {
		try {
			Response response = makePingRequest(API_URL);

			if (response.isSuccessful()) {
				System.out.println("Ping bem-sucedido: API ativa.");
			} else {
				System.out.println("Falha no ping: " + response.code());
			}
		} catch (IOException e) {
			System.out.println("Erro ao tentar fazer o ping: " + e.getMessage());
		}
	}

	public static Response makePingRequest(String url) throws IOException {
		Request request = new Request.Builder()
				.url(url)
				.get()
				.build();

		return client.newCall(request).execute();
	}
}
