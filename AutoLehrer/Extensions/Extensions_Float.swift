extension Float {
    func formattedString(decimalPlaces: Int) -> String {
        String(format: "%.\(decimalPlaces)f", self)
    }
}
