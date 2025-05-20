report 51821 "Store issue"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Store issue.rdl';

    dataset
    {
        dataitem("Requisition Header"; "Requisition Header")
        {
            //RequestFilterFields = "No.", "Employee Code", Status, "Issued By";
            column(No; "Requisition Header"."No.")
            {
            }
            column(LineNo; LineNo)
            {
            }
            column(LineDesc; Desc)
            {
            }
            column(LoCode; LoCode)
            {
            }
            column(UOM; UOM)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(QApproved; QApproved)
            {
            }
            column(UnitPrice; UnitPrice)
            {
            }
            column(Amount; Amount)
            {
            }
            column(JobNo; JobNo)
            {
            }
            column(Desc; Description)
            {
            }
            column(CustomerNo; CustomerNo)
            {
            }
            column(CustName; Name)
            {
            }
            column(PostDate; PostDate)
            {
            }
            column(Picture; CompInfor.Picture)
            {
            }
            column(CompName; CompInfor.Name)
            {
            }
            column(CompName1; CompInfor."Name 2")
            {
            }
            column(Requisitioning_Officer; "Raised by")
            {
            }
            column(Issued_By; "Issued By")
            {
            }
            column(Received_By; "Received From")
            {
            }
            trigger OnAfterGetRecord()
            begin
                PostDate:=WorkDate;
                RequisitionLines.Reset;
                RequisitionLines.SetRange(Status, RequisitionLines.Status::Released);
                RequisitionLines.SetRange("Requisition No", "Requisition Header"."No.");
                if RequisitionLines.FindSet then repeat LineNo:=RequisitionLines."Requisition No";
                        Desc:=RequisitionLines.Description;
                        LoCode:=RequisitionLines."Location Code";
                        UOM:=RequisitionLines."Unit of Measure";
                        Quantity:=RequisitionLines.Quantity;
                        QApproved:=RequisitionLines."Quantity Approved";
                        Amount:=RequisitionLines.Amount;
                    until RequisitionLines.Next = 0;
                RequisitionLines.Reset;
                RequisitionLines.SetRange(Status, RequisitionLines.Status::Released);
                RequisitionLines.SetRange("Requisition No", "Requisition Header"."No.");
                if RequisitionLines.FindFirst then begin
                    if Job.Get(RequisitionLines."Job No")then begin
                        JobNo:=Job."No.";
                        Description:=Job.Description;
                        CustomerNo:=Job."Bill-to Customer No.";
                        Name:=Job."Bill-to Name";
                    end;
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
        CompInfor.Get;
        CompInfor.CalcFields(Picture);
    end;
    var RequisitionHeader: Record "Requisition Header";
    Job: Record Job;
    Description: Text;
    CustomerNo: Code[20];
    Name: Text;
    RequisitionLines: Record "Requisition Lines";
    JobNo: Code[20];
    LineNo: Code[20];
    Desc: Text;
    LoCode: Code[20];
    UOM: Code[20];
    Quantity: Decimal;
    QApproved: Decimal;
    UnitPrice: Decimal;
    Amount: Decimal;
    PostDate: Date;
    CompInfor: Record "Company Information";
}
