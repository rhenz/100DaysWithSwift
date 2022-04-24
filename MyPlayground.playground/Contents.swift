import Foundation

func doubleValues(in nums: [Int], matching shouldDouble: (Int) -> Bool) -> [Int] {
    var finalValues = [Int]()
    for num in nums {
        finalValues.append(num * (shouldDouble(num) ? 2 : 1))
    }
    return finalValues
}
 
let nums = [1,2,3,4,5]
//doubleValues(in: nums) { num in
//    num.isMultiple(of: 2)
//}

doubleValues(in: nums, matching: { $0.isMultiple(of: 2)})
nums.sorted(by: <)
