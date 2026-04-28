package com.vedhansri.controller;

import com.vedhansri.model.Course;
import com.vedhansri.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/academy")
public class AcademyController {

    @Autowired
    private CourseRepository courseRepository;

    @GetMapping("/courses")
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    @PostMapping("/add-course")
    public Course addCourse(@RequestBody Course course) {
        return courseRepository.save(course);
    }
}