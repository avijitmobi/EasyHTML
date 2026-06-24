# EasyHTML

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift 5.9">
    <img src="https://img.shields.io/badge/iOS-15.0+-blue.svg" alt="iOS 15.0+">
    <img src="https://img.shields.io/badge/SwiftUI-✅-green.svg" alt="SwiftUI">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License">
</p>

A clean, reusable, and highly customizable HTML viewer for SwiftUI with **dynamic height**, **custom fonts**, and **extensive styling options**. Built with a modular architecture so you can control every pixel of your HTML content.

## ✨ Features

- 📏 **Dynamic Height** – Automatically resizes to fit HTML content perfectly.
- 🔤 **Smart Fonts** – Pass a custom font family, or pass `nil` to gracefully fallback to the system font.
- 🎨 **Complete Color Control** – Text, secondary text, background, and link colors.
- 🧱 **Element-Level Styling** – Customize Links, Images, Headings, Lists, Code Blocks, Tables, Blockquotes, and Horizontal Rules.
- 🌙 **Built-in Presets** – Dark mode, Sepia reader mode, and more out of the box.
- ⏳ **Optional Loader** – Tiny, elegant loading indicator (only shows when explicitly enabled).
- 🧩 **Modular Codebase** – 16 dedicated configuration files for maximum readability and customization.

---

## 📦 Installation

### Swift Package Manager

1. In Xcode, go to **File > Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/avijitmobi/EasyHTML`
3. Select your version and target, then click **Add Package**.

---

## 🚀 Quick Start

```swift
import SwiftUI
import EasyHTML

struct ContentView: View {
    var body: some View {
        ScrollView {
            // 1. Basic Usage (Uses System Font automatically)
            EasyHTML(html: "<h1>Hello World</h1><p>This is standard text.</p>")
            
            // 2. Custom Font
            EasyHTML(html: "<p>Elegant reading.</p>")
                .font(family: "Georgia", size: 18)
            
            // 3. Dark Mode
            EasyHTML(html: "<p>Night mode.</p>", configuration: .darkMode)
        }
    }
}
```

---

## 📖 Detailed Feature Guide

### 1. Content Sources (`EasyHTMLContent.swift`)
You can initialize `EasyHTML` using three different input types:
```swift
// Raw HTML String
EasyHTML(html: "<p>String</p>")

// URL Object
EasyHTML(url: URL(string: "https://example.com")!)

// URL String
EasyHTML(urlString: "https://example.com")
```

### 2. Font Configuration (`FontConfiguration.swift`)
Controls the base typography. If you pass `nil` to the family name, it automatically uses the native iOS system font (`-apple-system`).

```swift
EasyHTML(html: content)
    // Custom Font
    .font(family: "Georgia", size: 18, weight: "bold")
    
    // System Font (Explicit)
    .font(family: nil, size: 16)
    
    // Using Presets
    .font(.serif)       // Georgia
    .font(.monospace)   // Menlo
```
**Customizable Properties:** `familyName`, `size`, `weight`, `style`, `letterSpacing`, `textTransform`, `textAlign`.

### 3. Color Configuration (`ColorConfiguration.swift`)
Controls the color palette of the HTML body.

```swift
EasyHTML(html: content)
    // Apply Preset
    .colors(.dark)   // White text, black background
    .colors(.sepia)  // Warm reading tones
    
    // Fully Custom
    .colors(ColorConfiguration(
        text: "#333333",
        secondaryText: "#888888",
        background: "#F9F9F9",
        link: "#FF5733"
    ))
```

### 4. Spacing & Padding (`SpacingConfiguration.swift`)
Controls layout breathing room, line height, and margins.

```swift
EasyHTML(html: content)
    // Line Height multiplier (e.g., 1.5 means 150% of font size)
    .lineHeight(1.8)
    
    // Custom Edge Insets (Top, Bottom, Left, Right)
    .contentPadding(EdgeInsets(top: 20, bottom: 20, left: 24, right: 24))
    
    // Using Presets
    .spacing(.compact)     // Tight UI
    .spacing(.standard)    // Default
```

### 5. Link Styling (`LinkStyle.swift`)
Controls how `<a>` tags appear.
```swift
EasyHTML(html: "<a href='#'>Click me</a>")
    // Apply Preset
    .linkStyle(.underlined) // Always show underline
```

### 6. Image Styling (`ImageStyle.swift`)
Controls how `<img>` tags are rendered.
```swift
EasyHTML(html: "<img src='...' />")
    // Apply Presets
    .imageStyle(.rounded)   // 8px border radius
    .imageStyle(.circular)  // Perfect circle
```

### 7. Heading Styling (`HeadingStyle.swift`)
Controls `h1` through `h6` tags. You can customize their weight, text transform, and size multipliers relative to the base font.
```swift
EasyHTML(html: "<h1>Big Title</h1>")
    // Note: Heading styles are applied via the master configuration
    .configure(EasyHTMLConfiguration(
        headingStyle: HeadingStyle(weight: "bold", sizeMultipliers: [2.5, 2.0, 1.5, 1.2, 1.0, 0.8])
    ))
```

### 8. List Styling (`ListStyle.swift`)
Controls `<ul>` and `<ol>` indentation and markers.
```swift
EasyHTML(html: "<ul><li>Item 1</li></ul>")
    .configure(EasyHTMLConfiguration(
        listStyle: ListStyle(unorderedMarker: "square") // Changes bullet to square
    ))
```

### 9. Code Block Styling (`CodeBlockStyle.swift`)
Differentiates between inline `<code>` and block `<pre><code>` elements. Uses safe structs for padding.
```swift
EasyHTML(html: "<code>inline</code> <pre><code>block</code></pre>")
    // Light code blocks instead of dark, custom padding
    .configure(EasyHTMLConfiguration(codeStyle: CodeBlockStyle(
        blockBackground: "#F5F5F5",
        blockTextColor: "#333333",
        inlinePadding: InlinePadding(horizontal: 6, vertical: 2)
    )))
```

### 10. Table Styling (`TableStyle.swift`)
Controls borders, headers, and alternating row colors. Uses safe structs for cell padding.
```swift
EasyHTML(html: "<table><tr><th>Header</th></tr></table>")
    // Modern rounded, striped table
    .configure(EasyHTMLConfiguration(tableStyle: TableStyle(
        borderColor: "#E8E8E8",
        headerBackground: "#F8F9FA",
        alternatingRows: true,
        borderRadius: 8,
        cellPadding: CellPadding(horizontal: 16, vertical: 10)
    )))
```

### 11. Blockquote Styling (`BlockquoteStyle.swift`)
Controls the classic left-border accent or card-style blockquotes. Uses safe structs for padding.
```swift
EasyHTML(html: "<blockquote>Quote</blockquote>")
    // Change border color and width
    .configure(EasyHTMLConfiguration(
        blockquoteStyle: BlockquoteStyle(
            borderWidth: 5,
            borderColor: "#FF0000",
            padding: BlockquotePadding(left: 20, vertical: 12, right: 0)
        )
    ))
```

### 12. Selection & Horizontal Rules (`SelectionStyle.swift` & `HorizontalRuleStyle.swift`)
Control what happens when the user highlights text, and how `<hr>` tags look.
```swift
EasyHTML(html: "<hr>")
    .configure(EasyHTMLConfiguration(
        selectionStyle: SelectionStyle(backgroundColor: "#FFCC00"), // Yellow highlight
        ruleStyle: HorizontalRuleStyle(height: 3, color: "#CCCCCC")
    ))
```

---

## ⚙️ Behavioral Features

### Dynamic Height (Automatic)
By default, `EasyHTML` calculates its height automatically based on the HTML content using a lightweight JavaScript injection (`HTMLWrapper.swift`). You do not need to set a frame. Just drop it in a `ScrollView` or `VStack`.

### Loading Indicator (Optional)
By default, the loader is **hidden** to keep the UI clean. If you are loading heavy HTML or fetching from a URL, turn it on:
```swift
EasyHTML(html: content)
    .showLoader(true) // Shows a small ProgressView while loading
```

### Scrollable Mode (For URLs)
If you are loading a full website via URL, you likely want it contained in a fixed height with scrolling enabled:
```swift
EasyHTML(url: URL(string: "https://apple.com")!)
    .scrollable(true) // Enables internal scrolling
    .frame(height: 500) // You MUST provide a frame if scrollable is true
```

---

## 🏗️ Architecture & File Structure

This library is heavily modularized so you only import what Xcode compiles, and you can easily find the exact property you want to tweak.

```text
EasyHTML/
├── Package.swift                          # SPM Setup
└── Sources/
    └── EasyHTML/
        ├── Core/
        │   ├── EasyHTML.swift                     # The main SwiftUI View
        │   ├── EasyHTMLContent.swift              # Enum for HTML/URL inputs
        │   └── EasyHTMLWebViewRepresentable.swift # WKWebView logic & Coordination
        ├── Configuration/
        │   ├── EasyHTMLConfiguration.swift        # Master config & Fluent API builder
        │   ├── FontConfiguration.swift            # Typography rules
        │   ├── ColorConfiguration.swift           # Color palette rules
        │   ├── SpacingConfiguration.swift         # Padding & margins rules
        │   ├── LinkStyle.swift                    # <a> tag rules
        │   ├── ImageStyle.swift                   # <img> tag rules
        │   ├── HeadingStyle.swift                 # <h1>-<h6> rules
        │   ├── ListStyle.swift                    # <ul>, <ol> rules
        │   ├── CodeBlockStyle.swift               # <code>, <pre> rules
        │   ├── TableStyle.swift                   # <table> rules
        │   ├── BlockquoteStyle.swift              # <blockquote> rules
        │   ├── HorizontalRuleStyle.swift          # <hr> rules
        │   └── SelectionStyle.swift               # ::selection rules
        ├── Utilities/
        │   ├── CSSGenerator.swift                 # Converts Config structs into raw CSS
        │   └── HTMLWrapper.swift                  # Wraps HTML in <style> & Height JS
        └── Extensions/
            ├── String+Color.swift                 # Helper to convert Hex to SwiftUI Color
            └── View+EasyHTML.swift                # SwiftUI View extensions
```

---

## 📄 License

EasyHTML is released under the MIT License. See `LICENSE` for details.

---
**Built with ❤️ by [Avijit Mondal](https://avijit.dev)**
