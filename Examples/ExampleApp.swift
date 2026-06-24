//
//  ExampleApp.swift
//  EasyHTMLExample
//
//  Created by Avijit Mondal
//
//  INSTRUCTIONS:
//  1. Open the EasyHTML folder in Xcode.
//  2. Go to File > New > Target > iOS > App (SwiftUI).
//  3. Replace the contents of ContentView.swift with this file.
//  4. Add `import EasyHTML` at the top.
//  5. Run on Simulator!
//

import SwiftUI
// import EasyHTML // <-- UNCOMMENT THIS IN YOUR XCODE TARGET

struct ExampleApp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    
                    // MARK: - 1. Basic System Font & Headings
                    sectionHeader("1. Basic HTML & Headings (System Font)")
                    EasyHTML(html: """
                    <h1>Level 1 Heading</h1>
                    <h2>Level 2 Heading</h2>
                    <h3>Level 3 Heading</h3>
                    <p>This paragraph uses the default system font. The height of this view is entirely dynamic, expanding automatically as content grows.</p>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                    """)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 2. Custom Font (Georgia)
                    sectionHeader("2. Custom Font (Georgia, 18pt)")
                    EasyHTML(html: """
                    <p>This text uses a custom font family passed via the modifier. Notice how elegant serif fonts look for reading long paragraphs.</p>
                    <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                    """)
                    .font(family: "Georgia", size: 18)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 3. Links & Underlines
                    sectionHeader("3. Links (Underlined Style)")
                    EasyHTML(html: """
                    <p>You can click this <a href="https://apple.com">underlined link to Apple</a> to test routing, or this <a href="#">default link</a>.</p>
                    <p>By default, links have no decoration unless you apply the <code>.underlined</code> style preset.</p>
                    """)
                    .linkStyle(.underlined)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 4. Lists (Ordered & Unordered)
                    sectionHeader("4. Lists (Disc & Decimal)")
                    EasyHTML(html: """
                    <h3>Unordered List</h3>
                    <ul>
                        <li>Dynamic Height calculation</li>
                        <li>Custom Fonts support</li>
                        <li>Dark mode ready</li>
                    </ul>
                    
                    <h3>Ordered List</h3>
                    <ol>
                        <li>Open Xcode</li>
                        <li>Add Package</li>
                        <li>Import EasyHTML</li>
                    </ol>
                    """)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 5. Code Blocks (Dark vs Light)
                    sectionHeader("5. Code Blocks (Dark Preset)")
                    EasyHTML(html: """
                    <p>You can write inline code like <code>let view = EasyHTML()</code> easily.</p>
                    
                    <pre><code>struct ContentView: View {
    var body: some View {
        ScrollView {
            EasyHTML(html: htmlString)
                .font(family: "Menlo", size: 14)
        }
    }
}</code></pre>
                    """)
                    .configure(EasyHTMLConfiguration(codeStyle: .github)) // Dark GitHub style
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 6. Tables (Modern Striped)
                    sectionHeader("6. Tables (Modern Striped Style)")
                    EasyHTML(html: """
                    <table>
                        <tr>
                            <th>Feature</th>
                            <th>Status</th>
                            <th>Notes</th>
                        </tr>
                        <tr>
                            <td>Dynamic Height</td>
                            <td>✅</td>
                            <td>Automatic via JS injection</td>
                        </tr>
                        <tr>
                            <td>Custom Fonts</td>
                            <td>✅</td>
                            <td>Falls back to system if nil</td>
                        </tr>
                        <tr>
                            <td>URL Loading</td>
                            <td>✅</td>
                            <td>Requires .scrollable(true)</td>
                        </tr>
                    </table>
                    """)
                    .configure(EasyHTMLConfiguration(
                        tableStyle: TableStyle(
                            borderColor: "#E8E8E8",
                            headerBackground: "#F8F9FA",
                            alternatingRows: true,
                            borderRadius: 8,
                            cellPadding: CellPadding(horizontal: 12, vertical: 10)
                        )
                    ))
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 7. Blockquotes (Card Style)
                    sectionHeader("7. Blockquotes (Card Style)")
                    EasyHTML(html: """
                    <p>Here is a standard blockquote with a card background:</p>
                    <blockquote>
                        <p>The best way to predict the future is to invent it. EasyHTML makes rendering web content in native iOS apps effortless.</p>
                    </blockquote>
                    <p>And it continues flowing naturally with dynamic height.</p>
                    """)
                    .configure(EasyHTMLConfiguration(
                        blockquoteStyle: BlockquoteStyle(
                            borderWidth: 0,
                            backgroundColor: "#E8F4FD",
                            fontStyle: "normal",
                            padding: BlockquotePadding(left: 16, vertical: 16, right: 16),
                            borderRadius: 12
                        )
                    ))
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 8. Horizontal Rule & Loader Demo
                    sectionHeader("8. Horizontal Rule & Loader Toggle")
                    EasyHTML(html: """
                    <p>Content above the line.</p>
                    <hr>
                    <p>Content below the line. Notice how the <code>&lt;hr&gt;</code> styling is completely customizable.</p>
                    """)
                    .configure(EasyHTMLConfiguration(
                        ruleStyle: HorizontalRuleStyle(height: 2, color: "#007AFF", margin: 20)
                    ))
                    .showLoader(true) // Toggle this to true to see the small loader on initial load
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 9. Full Dark Mode
                    sectionHeader("9. Full Dark Mode")
                    EasyHTML(html: """
                    <h2>Dark Mode Active</h2>
                    <p>This entire block uses the <code>.darkMode</code> preset. Links, text, and backgrounds automatically invert.</p>
                    <ul>
                        <li>Seamless integration</li>
                        <li>No flickering</li>
                    </ul>
                    """)
                    .configure(.darkMode)
                    .contentPadding(.uniform(16))
                    .background(Color.black)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - 10. Reader Mode (Sepia)
                    sectionHeader("10. Reader Mode (Sepia, Serif, Comfortable)")
                    EasyHTML(html: """
                    <h2>Deep Dive into Reader Mode</h2>
                    <p>The Reader preset is optimized for long-form articles. It uses a serif font, sepia background color, comfortable line height (1.8), and generous padding to reduce eye strain.</p>
                    <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                    <blockquote>This is how quotes look in reader mode—subtle and elegant.</blockquote>
                    <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
                    """)
                    .configure(.reader)
                    .contentPadding(EdgeInsets(top: 20, bottom: 20, left: 24, right: 24))
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
    
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

// Helper for hex colors in SwiftUI Preview
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
