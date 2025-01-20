# Dog Image Generator App

## Description

The Dog Image Generator App is an iOS application built using UIKit and the MVVM architecture. It allows users to generate random images of dogs, save them for later viewing, and manage these images using LRU caching system that persists across user sessions. 

## Features

- **Generate Dog Images:** Fetch random dog images from a public API.

- **Image Gallery:** View recently generated dog images in a collection view.

- **Efficient Caching:** Uses an LRU (Least Recently Used) cache to store up to 20 images.

- **Offline Support:** Persist cached images between app sessions.

- **Cache Management**: Clear cache and gallery when needed.


## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture for clear separation of concerns:

- **View Controllers:** Manage the UI and user interactions.

- **View Models:** Handle business logic and communicate with models.

- **Models:** Represent data structures such as images and cache.

## Cache System

- **LRU Cache:** Stores up to 20 dog images, removing the least recently used image when the limit is exceeded.

- **Persistence:** Saves cached images to disk for retrieval between app sessions.



## API Integration

- **Public API:** Fetch random dog images from the Dog API.

- **Endpoint:** https://dog.ceo/api/breeds/image/random

## How to Run the Project

- Clone the repositoy:

- git clone https://github.com/anjalisreekumar/dog-image-generator-app.git

- Open the project in Xcode.

- Ensure the required iOS version and dependencies are installed.

- Run the app on a simulator or physical device.

## Future Improvements

- Unit testing
