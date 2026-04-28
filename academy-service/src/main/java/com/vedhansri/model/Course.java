package com.vedhansri.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "academy_courses")
@Data
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String courseName;
    private Double durationMonths;
    private Double fee;
}