package com.codeverse;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class CodeVerseApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(CodeVerseApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(CodeVerseApplication.class, args);
        System.out.println("╔═══════════════════════════════════════════════╗");
        System.out.println("║   CodeVerse Hackathon Marketplace Started!   ║");
        System.out.println("║   Access: http://localhost:8080/codeverse    ║");
        System.out.println("╚═══════════════════════════════════════════════╝");
    }
}
