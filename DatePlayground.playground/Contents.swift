import Foundation

let startTime: NSDate = NSDate()



let calendar = NSCalendar.current

var newYearsDayComponents = DateComponents()
newYearsDayComponents.year = 2015
newYearsDayComponents.month = 1
newYearsDayComponents.day = 1
let newYearsDay = calendar.date(from: newYearsDayComponents)!

var valentinesDayComponents = DateComponents()
valentinesDayComponents.year = 2015
valentinesDayComponents.month = 2
valentinesDayComponents.day = 14
valentinesDayComponents.hour = 9  // start the day at 9am for now
let valentinesDay = calendar.date(from: valentinesDayComponents)!


let diffVD2NYD = valentinesDay.timeIntervalSince(newYearsDay)
let diffNYD2VD = newYearsDay.timeIntervalSince(valentinesDay)


let diffDays = Int(diffVD2NYD / 86400)
let diffHours = Int((diffVD2NYD.truncatingRemainder(dividingBy: 86400))/(3600))

let diffVD2NYDAsString: String = String(format: "%02d:%02d", diffDays, diffHours)

var elapsedTime = startTime.timeIntervalSinceNow


