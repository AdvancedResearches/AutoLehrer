extension Float {
    func formattedString(decimalPlaces: Int) -> String {
        let retValue = String(format: "%.\(decimalPlaces)f", self)
        if(retValue == "nan"){
            return String(format: "%.\(decimalPlaces)f", 0.00)
        }
        return retValue
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
