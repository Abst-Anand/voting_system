package com.votingSystem.service;


import com.votingSystem.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

import com.votingSystem.entity.Image;

@Service
public class ImageService {

    @Autowired
    ImageRepository imageRepository;

    public Optional<Image> getImage(int id) {
        return imageRepository.getImageByImageId(id);
    }

    public Image saveImage(Image image) {
        return imageRepository.save(image);
    }

    public int deleteImage(int id) {
        return imageRepository.deleteImageByImageId(id);
    }

//    public int updateImage(Image image) {
//        return imageRepository.updateImage(image);
//    }

}