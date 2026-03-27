package com.codeverse.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "codeverse_user_types")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeVerseUserType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_type_id")
    private Integer userTypeId;

    @Column(name = "user_type_name", nullable = false, unique = true, length = 50)
    private String userTypeName;

    @Column(name = "user_type_description")
    private String userTypeDescription;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
