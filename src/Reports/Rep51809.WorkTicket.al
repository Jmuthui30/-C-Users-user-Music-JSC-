report 51809 "Work Ticket"
{
    // version THL- PRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Work Ticket.rdlc';

    dataset
    {
        dataitem("Work Ticket Header"; "Work Ticket Header")
        {
            RequestFilterFields = "No.";

            column(Logo; CompInfo.Picture)
            {
            }
            column(Logo2; CompInfo.Picture2)
            {
            }
            column(Watermark; AdvancedFinanceSetup."Watermark Portrait")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompAddress2; CompInfo."Address 2")
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(CompCountry; CompInfo."Country/Region Code")
            {
            }
            column(VehicleRegNo; "Work Ticket Header".Vehicle)
            {
            }
            column(SheetNo; "Work Ticket Header"."No.")
            {
            }
            column(IssuedDate; "Work Ticket Header"."Issued Date")
            {
            }
            column(ClosedDate; "Work Ticket Header"."Closed Date")
            {
            }
            column(AuthorizingOfficer; "Work Ticket Header"."Authorising Officer Name")
            {
            }
            dataitem("Work Ticket Drivers"; "Work Ticket Drivers")
            {
                DataItemLink = "No."=FIELD("No.");

                column(Counter; Counter)
                {
                }
                column(DiversNames; "Work Ticket Drivers"."Driver Name")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Counter:=Counter + 1;
                end;
                trigger OnPreDataItem()
                begin
                    Counter:=0;
                end;
            }
            dataitem("Work Ticket Lines"; "Work Ticket Lines")
            {
                DataItemLink = "No."=FIELD("No.");

                column(Date; "Work Ticket Lines".Date)
                {
                }
                column(DriverNo; "Work Ticket Lines".Driver)
                {
                }
                column(DriverName; "Work Ticket Lines"."Driver Name")
                {
                }
                column(Details; "Work Ticket Lines".Details)
                {
                }
                column(Project; "Work Ticket Lines"."Global Dimension 1 Code")
                {
                }
                column(TimeOut; "Work Ticket Lines"."Time Out")
                {
                }
                column(TimeIn; "Work Ticket Lines"."Time In")
                {
                }
                column(OdometerAtBeginning; "Work Ticket Lines"."Odometer Reading at Start (KM)")
                {
                }
                column(OdometerAtEnd; "Work Ticket Lines"."Odometer Reading at End (KM)")
                {
                }
                column(DistanceCovered; "Work Ticket Lines"."Distance Covered (KM)")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
            /*UserRec.RESET;
                UserRec.SETRANGE("User Name","Work Ticket Header"."Authorising Officer");
                IF UserRec.FINDFIRST THEN
                  PreparedBy := UserRec."Full Name";*/
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
        CompInfo.CalcFields(Picture2);
        AdvancedFinanceSetup.Get;
        AdvancedFinanceSetup.CalcFields("Watermark Portrait");
    end;
    var CompInfo: Record "Company Information";
    UserRec: Record User;
    PreparedBy: Text;
    ProcurementSetup: Record "Procurement Setup";
    ReviewedBy: Text;
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    Counter: Integer;
}
