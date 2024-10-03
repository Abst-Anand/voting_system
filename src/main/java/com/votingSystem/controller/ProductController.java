package com.votingSystem.controller;

import com.votingSystem.entity.ProductEntity;
import com.votingSystem.repository.ProductRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/products")
public class ProductController {

    private final int PAGE_SIZE = 5;
    private final ProductRepository productRepository;

    public ProductController(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @GetMapping
    Page<ProductEntity> getAllProducts(
            @RequestParam(defaultValue = "id") String sortBy,
            @RequestParam(defaultValue = "0")int pageNumber) {
//        return productRepository.findBy(Sort.by(sortBy, "price"));

        return productRepository.findAll(PageRequest.of(pageNumber,PAGE_SIZE, Sort.by(sortBy)));
    }
}