report 51603 "Employee Details"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Employee Details.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", City, "Birth Date", Gender, "Manager No.", "Employment Date", Status, "Global Dimension 1 Code", "Global Dimension 2 Code", "Resource No.";

            column(Logo; CompInfo.Picture)
            {
            }
            column(USER; UserId)
            {
            }
            column(DT; CurrentDateTime)
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(EmpNo; Employee."No.")
            {
            }
            column(FirstName; Employee."First Name")
            {
            }
            column(MiddleName; Employee."Middle Name")
            {
            }
            column(LastName; Employee."Last Name")
            {
            }
            column(JobTitle; Employee."Job Title")
            {
            }
            column(Gender; Employee.Gender)
            {
            }
            column(EmploymentDate; Employee."Employment Date")
            {
            }
            column(Phone; Employee."Birth Date")
            {
            }
            column(Mobile; Employee."Mobile Phone No.")
            {
            }
            column(Email; Employee."E-Mail")
            {
            }
            column(CompanyEmail; Employee."Company E-Mail")
            {
            }
            column(County; Employee.County)
            {
            }
            column(DimOne; Employee."Global Dimension 1 Code")
            {
            }
            column(DimTwo; Employee."Global Dimension 2 Code")
            {
            }
            column(ResourceNo; Employee."Resource No.")
            {
            }
            column(IDNo; IDNo)
            {
            }
            column(PassportNo; PassportNo)
            {
            }
            column(DLNo; DLNo)
            {
            }
            column(PINNo; PINNo)
            {
            }
            column(NSSFNo; NSSFNo)
            {
            }
            column(SHIFNo; SHIFNo)
            {
            }
            column(BankName; BankName)
            {
            }
            column(Branch; Branch)
            {
            }
            column(AccountNo; AccountNo)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if OurEmp.Get(Employee."No.")then begin
                    IDNo:=OurEmp."ID Number";
                    PassportNo:=OurEmp."Passport No.";
                    DLNo:=OurEmp."Driving License No";
                    Disability:=OurEmp.Disability;
                    MaritalStatus:=Format(OurEmp."Marital Status");
                    PINNo:=OurEmp."PIN Number";
                    NSSFNo:=OurEmp."NSSF No";
                    SHIFNo:=OurEmp."SHIF No";
                    AccountNo:=OurEmp."Bank Account Number";
                    CommercialBanks.Reset;
                    CommercialBanks.SetRange(Code, OurEmp."Bank Code");
                    if CommercialBanks.FindFirst then BankName:=CommercialBanks.Name;
                    BankBranches.Reset;
                    BankBranches.SetRange("Bank Code", OurEmp."Bank Code");
                    BankBranches.SetRange("Branch Code", OurEmp."Bank Branch");
                    if BankBranches.FindFirst then Branch:=BankBranches."Branch Name";
                end;
            end;
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
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        ReportFilters:=Employee.GetFilters;
    end;
    var CompInfo: Record "Company Information";
    ReportFilters: Text;
    OurEmp: Record "Employee Master";
    IDNo: Code[20];
    PassportNo: Code[20];
    DLNo: Code[20];
    Disability: Text;
    MaritalStatus: Text;
    PINNo: Code[20];
    NSSFNo: Code[20];
    SHIFNo: Code[20];
    CommercialBanks: Record "Commercial Banks";
    BankName: Text;
    BankBranches: Record "Bank Branches";
    Branch: Text;
    AccountNo: Code[20];
}
