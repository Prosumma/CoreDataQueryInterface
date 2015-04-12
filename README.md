# Core Data Query Interface

CDQI is a type-safe, fluent library for working with Core Data in Swift. The syntax speaks for itself:

    let employees = moc.from(Employee).filter("salary > 80000").all()
    let highestPaidEmployeeName = moc.from(Employee).order(descending: "salary").select("name").first()
    let highestSalary: NSNumber = moc.from(Employee).max("salary").pluck("salary")!


