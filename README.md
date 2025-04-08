# Green Office Park Coffee Finder ☕📍

An iOS app built with **SwiftUI** that helps users discover coffee shops within **Green Office Park, BSD – Tangerang**. Designed with privacy, efficiency, and user experience in mind using Apple-native frameworks: **CoreLocation**, **CoreMotion**, **MapKit**, and **HealthKit**.

---

## 🔧 Tech Stack

- **SwiftUI** – Modern declarative UI framework.
- **CoreLocation** – Efficient and privacy-respecting location services.
- **CoreMotion** – Lightweight, on-device activity tracking.
- **MapKit** – Native map rendering and geolocation support.
- **HealthKit** – (Optional) Access to step count and calories burned.

---

## ⚙️ Core Features

- **📍 Route & Location Mapping** _(CoreLocation + MapKit)_  
  The app uses **CoreLocation** to determine the user's current location and **MapKit** to display a live map with walking routes to selected coffee shops. It provides real-time distance and estimated time of arrival (ETA).

- **🏃‍♂️ Live Step Counter** _(CoreMotion)_  
  Once navigation is initiated, **CoreMotion** is used to track the user's step count in real time as they walk toward the destination. This is done fully on-device with low energy impact.

- **🧠 Daily Activity Summary** _(HealthKit)_  
  Pulls activity summary data from **HealthKit** to display today’s total steps, distance walked, and calories burned — giving users a broader health context for their coffee runs.

- **🗺️ Offline Coffee Shop Directory**  
  Coffee shop locations are hardcoded or cached locally to ensure fast access without requiring a network connection. This enhances privacy and performance.

- **🔒 Privacy-Respecting Design**  
  All location, motion, and health data stay on-device. No external servers, no cloud sync, no analytics. Just a focused, local experience.

---

## 📍 Coverage Area

Supported zone:

- **Green Office Park, BSD City – South Tangerang, Indonesia**

Preloaded coffee shops include:

- Starbucks GOP 9
- Tanamera Coffee
- Anomali Coffee
- Dua Coffee BSD
- Kopi Kalyan BSD
- (Easily extendable via local database or config)

---

## 🔐 Permissions Required

The app requests the following permissions:

- **Location When In Use**  
  `NSLocationWhenInUseUsageDescription`

- **Motion & Fitness**  
  `NSMotionUsageDescription`

- **Health Data Access** _(optional)_  
  `NSHealthShareUsageDescription`  
  `NSHealthUpdateUsageDescription`

---

## 🛡️ Security & Privacy Principles

- No third-party SDKs for analytics or tracking
- No background location tracking
- All sensitive data is processed on-device
- Minimal permission access — only what's strictly necessary

---

## 🚀 Getting Started (Coming Soon)

A full guide for installation, configuration, and building the project will be available in future updates.

---
