extension Float {
    func formattedString(decimalPlaces: Int) -> String {
        String(format: "%.\(decimalPlaces)f", self)
    }
    public static func maxFromArray(values: [Float]) -> Float{
        var retValue = values[0]
        for theCount in 1..<values.count {
            if values[theCount] > retValue {
                retValue = values[theCount]
            }
        }
        return retValue
    }
}
