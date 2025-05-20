xmlport 51453 "Import Employee Details"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement("Employee Import Lines";
    "Employee Import Lines")
    {
    XmlName = 'Payroll';

    fieldattribute(ConpanyNo;
    "Employee Import Lines".Company)
    {
    }
    fieldattribute(CompName;
    "Employee Import Lines"."Company Name")
    {
    }
    fieldattribute(PayrollNo;
    "Employee Import Lines"."Payroll No.")
    {
    }
    fieldattribute(FullName;
    "Employee Import Lines"."Full Name")
    {
    }
    fieldattribute(FirstName;
    "Employee Import Lines"."First Name")
    {
    }
    fieldattribute(MiddleName;
    "Employee Import Lines"."Middle Name")
    {
    }
    fieldattribute(LastName;
    "Employee Import Lines"."Last Name")
    {
    }
    fieldattribute(Title;
    "Employee Import Lines".Title)
    {
    }
    fieldattribute(Dept;
    "Employee Import Lines".Department)
    {
    }
    fieldattribute(Country;
    "Employee Import Lines".Country)
    {
    }
    fieldattribute(Gender;
    "Employee Import Lines".Gender)
    {
    }
    fieldattribute(DoB;
    "Employee Import Lines"."Date of Birth")
    {
    }
    fieldattribute(Address;
    "Employee Import Lines"."Postal Address")
    {
    }
    textattribute(paystax)
    {
    XmlName = 'PaysTax';
    }
    fieldattribute(IDNo;
    "Employee Import Lines"."ID Number")
    {
    }
    fieldattribute(PassportNo;
    "Employee Import Lines"."Passport Number")
    {
    }
    fieldattribute(MaritalStatus;
    "Employee Import Lines"."Marital Status")
    {
    }
    fieldattribute(PIN;
    "Employee Import Lines"."PIN No.")
    {
    }
    fieldattribute(NSSF;
    "Employee Import Lines"."NSSF No.")
    {
    }
    fieldattribute(SHIF;
    "Employee Import Lines"."SHIF No.")
    {
    }
    textattribute(paymode)
    {
    XmlName = 'PayMode';
    }
    fieldattribute("AccountNo.";
    "Employee Import Lines"."Account Number")
    {
    }
    fieldattribute(BankCode;
    "Employee Import Lines"."Bank Code")
    {
    }
    fieldattribute(BranchCode;
    "Employee Import Lines"."Branch Code")
    {
    }
    fieldattribute(StartingDate;
    "Employee Import Lines"."Starting Date")
    {
    }
    fieldattribute(DepartureDate;
    "Employee Import Lines"."Departture Date")
    {
    }
    fieldattribute(Basic;
    "Employee Import Lines"."Basic Salary")
    {
    }
    fieldattribute(PhoneNo;
    "Employee Import Lines"."Mobile Phone No.")
    {
    }
    fieldattribute(Email;
    "Employee Import Lines"."Email Address")
    {
    }
    textattribute(status)
    {
    XmlName = 'Status';
    }
    trigger OnBeforeInsertRecord()
    begin
        Counter:=Counter + 1;
        "Employee Import Lines"."No.":=BatchNo;
        "Employee Import Lines"."Line No.":=Counter;
        "Employee Import Lines"."System No.":=CompCode + '-' + "Employee Import Lines"."Payroll No.";
        if "Employee Import Lines".Company <> CompCode then Error('The Company Code on the Data Sheet is not the same as the company you have selected. Please check!');
    end;
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    trigger OnPreXmlPort()
    begin
        Counter:=0;
    end;
    var EmployeeHdr: Record "Employee Import Header";
    BatchNo: Code[20];
    CompCode: Code[20];
    Counter: Integer;
    procedure GetHeader(var Employee: Record "Employee Import Header")
    begin
        EmployeeHdr.Copy(Employee);
        BatchNo:=EmployeeHdr."No.";
        CompCode:=EmployeeHdr.Company;
    end;
}
