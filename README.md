# EasyHTML

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift 5.9">
    <img src="https://img.shields.io/badge/iOS-15.0+-blue.svg" alt="iOS 15.0+">
    <img src="https://img.shields.io/badge/SwiftUI-✅-green.svg" alt="SwiftUI">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License">
</p>

A clean, reusable, and highly customizable HTML viewer for SwiftUI with **dynamic height**, **custom fonts**, and **extensive styling options**.

## ✨ Features

- 🎨 **Full Customization** - Fonts, colors, spacing, links, images, headings, lists, code blocks, tables, blockquotes.
- 📏 **Dynamic Height** - Automatically adjusts to content size seamlessly.
- 🔤 **Custom Fonts** - Pass any font family, or leave it `nil` to gracefully fall back to the system font.
- 🌙 **Dark Mode & Reader Mode** - Built-in presets for dark themes and sepia reading modes.
- ⏳ **Optional Loader** - Small, elegant loading indicator (only shows if you pass `true`).
- 🧱 **Clean Architecture** - Modular, fully documented, SPM-ready.

## 📦 Installation

### Swift Package Manager

In Xcode:
1. File → Add Package Dependencies...
2. Enter: `https://github.com/avijitmondal/EasyHTML`
3. Select version and add to your target.

## 🚀 Quick Start

```swift
import SwiftUI
import EasyHTML

struct ContentView: View {
    var body: some View {
        ScrollView {
            // 1. Basic Usage (Uses System Font by default)
            EasyHTML(html: "<h1>Hello World</h1>")
            
            // 2. Custom Font
            EasyHTML(html: "<p>Custom font!</p>")
                .font(family: "Georgia", size: 18)
            
            // 3. Dark Mode
            EasyHTML(html: "<p>Dark mode!</p>", configuration: .darkMode)
            
            // 4. With Loader (Set to true to show)
            EasyHTML(html: "<p>Loading...</p>")
                .showLoader(true)
        }
    }
}
