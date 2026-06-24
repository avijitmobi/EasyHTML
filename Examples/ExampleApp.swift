//
//  ExampleApp.swift
//  EasyHTMLExample
//
//  Created by Avijit Mondal
//
//  HOW TO RUN THIS EXAMPLE:
//  1. Open the EasyHTML folder in Xcode (File -> Open -> Select EasyHTML folder)
//  2. Go to File -> New -> Target
//  3. Select "iOS" -> "App" -> Next
//  4. Product Name: "EasyHTMLExample", Interface: SwiftUI
//  5. Click Finish
//  6. Replace the generated ContentView.swift with this file's content.
//  7. Import EasyHTML at the top: import EasyHTML
//  8. Hit Cmd+R to Run!
//

import SwiftUI
// import EasyHTML  // <-- UNCOMMENT THIS IN YOUR XCODE TARGET

struct ExampleApp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    
                    // MARK: - 1. Basic Usage
                    sectionTitle("1. Basic HTML (System Font)")
                    EasyHTML(html: """
                    <h2>Welcome to EasyHTML</h2>
                    <p>This is a <strong>highly customizable</strong> HTML viewer built by <em>Avijit Mondal</em>.</p>
                    <p>It automatically calculates dynamic height!</p>
                    """)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 2. Custom Font
                    sectionTitle("2. Custom Font (Georgia, 18pt)")
                    EasyHTML(html: "<p>This text uses a custom font. Notice how elegant it looks compared to the system font.</p>")
                        .font(family: "Georgia", size: 18)
                        .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 3. Dark Mode
                    sectionTitle("3. Dark Mode Card")
                    EasyHTML(html: "<h3>Dark Mode</h3><p>Seamless dark mode support built right in.</p><p>Links <a href='#'>look great</a> too.</p>")
                        .colors(.dark)
                        .contentPadding(.uniform(16))
                        .background(Color.black)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 4. With Loader
                    sectionTitle("4. With Loading Indicator")
                    EasyHTML(html: "<p>I show a tiny loader while initializing if you enable it.</p>")
                        .showLoader(true)
                        .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 5. Rich Content (Code, Lists, Tables)
                    sectionTitle("5. Rich Content (Code, Tables, Lists)")
                    EasyHTML(html: """
                    <p>Here is some <code>inline code</code>.</p>
                    
                    <pre><code>func setupHTML() {
                        let view = EasyHTML(html: content)
                        return view
                    }</code></pre>
                    
                    <h3>Features</h3>
                    <ul>
                        <li>Dynamic Height</li>
                        <li>Custom Fonts</li>
                        <li>Dark Mode</li>
                    </ul>
                    
                    <table>
                        <tr><th>Component</th><th>Status</th></tr>
                        <tr><td>Links</td><td>✅</td></tr>
                        <tr><td>Tables</td><td>✅</td></tr>
                        <tr><td>Code Blocks</td><td>✅</td></tr>
                    </table>
                    """)
                    .codeStyle(.light) // Light code blocks for this example
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 6. Reader Mode (Sepia)
                    sectionTitle("6. Reader Mode (Sepia, Serif)")
                    EasyHTML(html: """
                    <h2>Reading Mode</h2>
                    <p>The quick brown fox jumps over the lazy dog. This mode is optimized for long-form article reading, using serif fonts and warm sepia tones to reduce eye strain.</p>
                    <blockquote>This is a blockquote. It looks beautiful in reader mode.</blockquote>
                    """)
                    .configure(.reader)
                    .contentPadding(.init(top: 16, bottom: 16, left: 20, right: 20))
                    .background(Color(hex: "#F4ECD8"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 50)
                }
                .padding(.top)
            }
            .navigationTitle("EasyHTML Examples")
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

// Helper for hex colors in SwiftUI
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6: r = Double(int >> 16) / 255; g = Double((int >> 8) & 0xFF) / 255; b = Double(int & 0xFF) / 255
        default: r = 0; g = 0; b = 0
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}

#Preview {
    ExampleApp()
}
