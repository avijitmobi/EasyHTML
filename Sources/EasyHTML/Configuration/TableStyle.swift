//
//  TableStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

// Helper struct to replace the Tuple
public struct CellPadding: Equatable {
    public let horizontal: CGFloat
    public let vertical: CGFloat
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

public struct TableStyle: Equatable {
    
    public let borderColor: String
    public let borderWidth: CGFloat
    public let borderCollapse: String
    public let headerBackground: String
    public let headerTextColor: String
    public let headerWeight: String
    public let cellPadding: CellPadding // Changed from tuple
    public let alternatingRows: Bool
    public let alternatingRowColor: String
    public let borderRadius: CGFloat
    public let overflow: String
    
    public init(
        borderColor: String = "#E0E0E0",
        borderWidth: CGFloat = 1,
        borderCollapse: String = "collapse",
        headerBackground: String = "#F5F5F5",
        headerTextColor: String? = nil,
        headerWeight: String = "bold",
        cellPadding: CellPadding = CellPadding(horizontal: 12, vertical: 8), // Updated default
        alternatingRows: Bool = false,
        alternatingRowColor: String = "#FAFAFA",
        borderRadius: CGFloat = 0,
        overflow: String = "auto"
    ) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.borderCollapse = borderCollapse
        self.headerBackground = headerBackground
        self.headerTextColor = headerTextColor ?? "#000000"
        self.headerWeight = headerWeight
        self.cellPadding = cellPadding
        self.alternatingRows = alternatingRows
        self.alternatingRowColor = alternatingRowColor
        self.borderRadius = borderRadius
        self.overflow = overflow
    }
    
    public static let `default` = TableStyle()
    public static let striped = TableStyle(alternatingRows: true)
    
    public static let borderless = TableStyle(
        borderColor: "transparent",
        borderWidth: 0,
        borderCollapse: "separate",
        headerBackground: "transparent"
    )
    
    public static let modern = TableStyle(
        borderColor: "#E8E8E8",
        headerBackground: "#F8F9FA",
        alternatingRows: true,
        alternatingRowColor: "#F8F9FA",
        borderRadius: 8,
        overflow: "hidden"
    )
}
