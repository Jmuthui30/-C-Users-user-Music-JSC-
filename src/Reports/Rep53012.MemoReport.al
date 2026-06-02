report 53012 "Memo Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSRS/Imprest Memo Report.rdl';

    dataset
    {
        dataitem("Imprest Memo Header"; "Imprest Memo Header")
        {
            column(CompInfoLogo; CompInfo.Picture)
            { }
            column(CompInfoName; CompInfo.Name) { }
            column(CompInfoAddress; CompInfo.Address) { }

            column(No_; "No.")
            {

            }
            column(To; "To")
            { }
            column(From_Title; "From Title")
            { }
            column(Recipient_Title; "Recipient Title") { }
            column(From; From) { }
            column(Date; Date) { }
            column(Subject; Subject) { }
            column(Message_body; "Message body") { }
            column(Message_body_1; "Message body 1") { }
            column(Recipient_Name; "Recipient Name") { }
            column(Sender_Name; "Sender Name") { }
            column(Total_Days_in_the_Field; "Total Days in the Field") { }
            //Approval flow
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            //
            column(Total_Grand_Total; TotalGrandTotal) { }
            dataitem("Imprest Memo Lines"; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where(DSA = filter(<> 0));

                column(Account_No_; "Account No.") { }
                column(Name; Name) { }
                column(Title; Title) { }
                column(Amount; dsa) { }
                column(Other_Costs; "Other Costs") { }
                column(Description; Description) { }
                column(No_of_Days; "Total Days in the Field") { }
                column(DSALine; DSAline)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    DSAline := DSAline + 1;

                end;



            }
            // Cordiantion Allowance
            dataitem(Cordiantion; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Cordination Allowance" = filter(<> 0));
                column(Cordiantion_Description; OtherAllowanceDesc) { }
                column(Cordination_Allowance; "Cordination Allowance") { }
                column(Cordiantion_Days; "Total Days in the Field") { }
                column(Cordiantion_Name; Name) { }
                column(Cordiantion_Account_No_; "Account No.") { }
                column(CordiantionLine; CordiantionLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // Skip records where ALL allowances are zero
                    if ("Cordination Allowance" = 0) and ("Facilitator Allowance" = 0) and
                       ("Secretariat Allowance" = 0) and ("Rapporteur Allowance" = 0) and
                       ("Retreat Allowance" = 0) and ("Expert Allowance" = 0) and
                       ("Out of Pocket Allowance" = 0) and ("Tuition Fee" = 0) and
                       ("Mileage Allowance" = 0) and ("Quarter Per Diem" = 0)
                    then
                        CurrReport.Skip();
                    if "Cordination Allowance" > 0 then
                        OtherAllowanceDesc := 'Cordiantion Allowance'
                    else if "Facilitator Allowance" > 0 then
                        OtherAllowanceDesc := 'Facilitator Allowance'
                    else if "Secretariat Allowance" > 0 then
                        OtherAllowanceDesc := 'Secretariat Allowance'
                    else if "Rapporteur Allowance" > 0 then
                        OtherAllowanceDesc := 'Rapporteur Allowance'
                    else if "Retreat Allowance" > 0 then
                        OtherAllowanceDesc := 'Retreat Allowance'
                    else if "Expert Allowance" > 0 then
                        OtherAllowanceDesc := 'Expert Allowance'
                    else if "Out of Pocket Allowance" > 0 then
                        OtherAllowanceDesc := 'Out of Pocket Allowance'
                    else if "Tuition Fee" > 0 then
                        OtherAllowanceDesc := 'Tuition Fee'
                    else if "Mileage Allowance" > 0 then
                        OtherAllowanceDesc := 'Mileage Allowance'
                    else if "Quarter Per Diem" > 0 then
                        OtherAllowanceDesc := 'Quarter Per Diem';


                    CordiantionLine := CordiantionLine + 1;

                end;
            }
            // Facilitator Allowance
            dataitem(Facilitator; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Facilitator Allowance" = filter(<> 0));
                column(Facilitator_Description; Description) { }
                column(Facilitator_Amount; "Facilitator Allowance") { }
                column(Facilitator_Days; "Total Days in the Field") { }
                column(Facilitator_Name; Name) { }
                column(Facilitator_Account_No_; "Account No.") { }
                column(FacilitatorLine; FacilitatorLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    FacilitatorLine := FacilitatorLine + 1;

                end;
            }
            //Secretariat Allowance
            dataitem(Secretariat; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Secretariat Allowance" = filter(<> 0));
                column(Secretariat_Description; Description) { }
                column(Secretariat_Amount; "Secretariat Allowance") { }
                column(Secretariat_Days; "Total Days in the Field") { }
                column(Secretariat_Name; Name) { }
                column(Secretariat_Account_No_; "Account No.") { }
                column(SecretariatLine; SecretariatLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SecretariatLine := SecretariatLine + 1;

                end;
            }
            // Rapporteur Allowance
            dataitem(Rapporteur; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Rapporteur Allowance" = filter(<> 0));
                column(Rapporteur_Description; Description) { }
                column(Rapporteur_Amount; "Rapporteur Allowance") { }
                column(Rapporteur_Days; "Total Days in the Field") { }
                column(Rapporteur_Name; Name) { }
                column(Rapporteur_Account_No_; "Account No.") { }
                column(RapporteurLine; RapporteurLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    RapporteurLine := RapporteurLine + 1;

                end;
            }
            // Driver Allowance
            dataitem(Driver; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Driver Allowance" = filter(<> 0));
                column(Driver_Description; Description) { }
                column(Driver_Amount; "Driver Allowance") { }
                column(Driver_Days; "Total Days in the Field") { }
                column(Driver_Name; Name) { }
                column(Driver_Account_No_; "Account No.") { }
                column(DriverLine; DriverLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    DriverLine := DriverLine + 1;

                end;
            }
            // Retreat Allowance
            dataitem(Retreat; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Retreat Allowance" = filter(<> 0));
                column(Retreat_Description; Description) { }
                column(Retreat_Amount; "Retreat Allowance") { }
                column(Retreat_Days; "Total Days in the Field") { }
                column(Retreat_Name; Name) { }
                column(Retreat_Account_No_; "Account No.") { }
                column(RetreatLine; RetreatLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    RetreatLine := RetreatLine + 1;

                end;
            }
            // Expert Allowance
            dataitem(Expert; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Expert Allowance" = filter(<> 0));
                column(Expert_Description; Description) { }
                column(Expert_Amount; "Expert Allowance") { }
                column(Expert_Days; "Total Days in the Field") { }
                column(Expert_Name; Name) { }
                column(Expert_Account_No_; "Account No.") { }
                column(ExpertLine; ExpertLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    ExpertLine := ExpertLine + 1;

                end;
            }
            // Air Ticket Allowance
            dataitem(AirTicket; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Air Ticket" = filter(<> 0));
                column(AirTicket_Description; Description) { }
                column(AirTicket_Amount; "Air Ticket") { }

                column(AirTicket_Name; Name) { }
                column(AirTicket_Account_No_; "Account No.") { }
                column(AirTicketLine; AirTicketLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    AirTicketLine := AirTicketLine + 1;

                end;
            }
            // Air Ticket

            // Conference
            dataitem(Conference; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Conference" = filter(<> 0));
                column(Conference_Description; Description) { }
                column(Conference_Amount; "Conference") { }

                column(Conference_Name; Name) { }
                column(Conference_Account_No_; "Account No.") { }
                column(ConferenceLine; ConferenceLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    ConferenceLine := ConferenceLine + 1;

                end;
            }
            // Ground Transport
            dataitem(GroundTransport; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Ground Transport" = filter(<> 0));
                column(GroundTransport_Description; Description) { }
                column(GroundTransport_Amount; "Ground Transport") { }

                column(GroundTransport_Name; Name) { }
                column(GroundTransport_Account_No_; "Account No.") { }
                column(GroundTransportLine; GroundTransportLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    GroundTransportLine := GroundTransportLine + 1;

                end;
            }
            // Accomodation
            dataitem(Accomodation; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Accomodation" = filter(> 0));
                column(Accomodation_Description; Description) { }
                column(Accomodation_Amount; "Accomodation") { }
                column(Accomodation_Days; "Total Days in the Field") { }
                column(Accomodation_Name; Name) { }
                column(Accomodation_Account_No_; "Account No.") { }
                column(AccomodationLine; AccomodationLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    AccomodationLine := AccomodationLine + 1;

                end;
            }
            // Out of Pocket Allowanc
            dataitem(OutOfPocketAllowance; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Out of Pocket Allowance" = filter(> 0));
                column(OutOfPocketAllowance_Description; Description) { }
                column(OutOfPocketAllowance_Amount; "Out of Pocket Allowance") { }
                column(OutOfPocketAllowance_Days; "Total Days in the Field") { }
                column(OutOfPocketAllowance_Name; Name) { }
                column(OutOfPocketAllowance_Account_No_; "Account No.") { }
                column(OutOfPocketAllowanceLine; OutOfPocketAllowanceLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    OutOfPocketAllowanceLine := OutOfPocketAllowanceLine + 1;

                end;
            }
            // Tuition Fee
            dataitem(TuitionFee; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Tuition Fee" = filter(> 0));
                column(TuitionFee_Description; Description) { }
                column(TuitionFee_Amount; "Tuition Fee") { }
                column(TuitionFee_Days; "Total Days in the Field") { }
                column(TuitionFee_Name; Name) { }
                column(TuitionFee_Account_No_; "Account No.") { }
                column(TuitionFeeLine; TuitionFeeLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TuitionFeeLine := TuitionFeeLine + 1;

                end;
            }
            // Mileage Allowance
            dataitem(MileageAllowance; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Mileage Allowance" = filter(> 0));
                column(MileageAllowance_Description; Description) { }
                column(MileageAllowance_Amount; "Mileage Allowance") { }
                column(MileageAllowance_Days; "Total Days in the Field") { }
                column(MileageAllowance_Name; Name) { }
                column(MileageAllowance_Account_No_; "Account No.") { }
                column(MileageAllowanceLine; MileageAllowanceLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    MileageAllowanceLine := MileageAllowanceLine + 1;

                end;
            }
            // Quarter Per Diem
            dataitem(QuarterPerDiem; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Quarter Per Diem" = filter(> 0));
                column(QuarterPerDiem_Description; Description) { }
                column(QuarterPerDiem_Amount; "Quarter Per Diem") { }
                column(QuarterPerDiem_Days; "Total Days in the Field") { }
                column(QuarterPerDiem_Name; Name) { }
                column(QuarterPerDiem_Account_No_; "Account No.") { }
                column(QuarterPerDiemLine; QuarterPerDiemLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    QuarterPerDiemLine := QuarterPerDiemLine + 1;

                end;
            }


            //other cost
            dataitem(OtherCost; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where("Other Costs" = filter(<> 0));
                column(OtherCost_Description; Description) { }
                column(OtherCost_Amount; "Other Costs") { }
                column(OtherCost_Days; "Total Days in the Field") { }
                column(OtherCost_Name; Name) { }
                column(OtherCost_Account_No_; "Account No.") { }
                column(OtherCostLine; OtherCostLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    OtherCostLine := OtherCostLine + 1;

                end;
            }
            trigger OnAfterGetRecord()
            begin
                RunLine := RunLine + 1;
                //Get sender ID even before approval sent
                Approver[1] := "Created By";
                ApproverDate[1] := CreateDateTime(Date, Time);
                if UserSetup.Get(Approver[1]) then
                    UserSetup.CalcFields(Signature);
                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Document No.", "No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;

                    until ApprovalEntries.Next() = 0;

                if Posted then begin
                    Approver[4] := "Posted By";
                    ApproverDate[4] := CreateDateTime(Date, Time);
                    if UserSetup3.Get(Approver[4]) then
                        UserSetup3.CalcFields(Signature);
                end;

                //// For testing purpose only, to be removed later
                MemoLineApp.SetRange("No.", "No.");
                if MemoLineApp.Find('-') then begin
                    repeat
                        if (MemoLineApp.DSA > 0) or (MemoLineApp."Cordination Allowance" > 0) or (MemoLineApp."Facilitator Allowance" > 0) or (MemoLineApp."Secretariat Allowance" > 0) or (MemoLineApp."Rapporteur Allowance" > 0) or (MemoLineApp."Retreat Allowance" > 0) or (MemoLineApp."Expert Allowance" > 0)
                         or (MemoLineApp."Out of Pocket Allowance" > 0) or (MemoLineApp."Tuition Fee" > 0) or (MemoLineApp."Mileage Allowance" > 0) or (MemoLineApp."Quarter Per Diem" > 0) then
                            TotalGrandTwice += (MemoLineApp.DSA + MemoLineApp."Cordination Allowance" + MemoLineApp."Facilitator Allowance" + MemoLineApp."Secretariat Allowance" + MemoLineApp."Rapporteur Allowance" + MemoLineApp."Retreat Allowance" + MemoLineApp."Expert Allowance"
                             + MemoLineApp."Out of Pocket Allowance" + MemoLineApp."Tuition Fee" + MemoLineApp."Mileage Allowance" + MemoLineApp."Quarter Per Diem") * memoLineApp."Total Days in the Field";
                        if (MemoLineApp."Air Ticket" > 0) or (MemoLineApp."Conference" > 0) or (MemoLineApp."Ground Transport" > 0) or (MemoLineApp.Accomodation > 0) then
                            TotalGrandonce += (MemoLineApp."Air Ticket" + MemoLineApp."Conference" + MemoLineApp."Ground Transport" + MemoLineApp.Accomodation);
                    until MemoLineApp.Next() = 0;
                    totalGrandTotal := TotalGrandonce + (TotalGrandTwice);
                end

            end;


        }
    }


    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {
                //nmjk
                //     }
                // }
            }
        }

        actions
        {
            // area(processing)
            // {
            //     action(LayoutName)
            //     {

            //     }
            // }
        }

    }

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var

        CordinationAllowance: Decimal;
        FacilitatorAllowance: Decimal;
        SecretariatAllowance: Decimal;
        RapporteurAllowance: Decimal;
        RetreatAllowance: Decimal;
        ExpertAllowance: Decimal;
        OutOfPocketAllowanceDec: Decimal;
        TuitionFeeDEC: Decimal;
        MileageAllowanceDec: Decimal;
        QuarterPerDiemDec: Decimal;
        OtherCostLine: Integer;
        myInt: Integer;
        CompInfo: Record "Company Information";
        CompanyInfo: Record "Company Information";
        BudgetLine: Integer;
        MemoLine: Integer;
        RunLine: Integer;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        ApproverDate: array[10] of DateTime;
        Approver: array[10] of Code[50];
        ApprovalEntries: Record "Approval Entry";
        FacilitatorLine: Integer;
        CordiantionLine: Integer;
        SecretariatLine: Integer;
        RapporteurLine: Integer;
        DriverLine: Integer;
        RetreatLine: Integer;
        Expertline: Integer;
        AirTicketLine: Integer;
        ConferenceLine: Integer;
        GroundTransportLine: Integer;
        AccomodationLine: Integer;
        OutOfPocketAllowanceLine: Integer;
        TuitionFeeLine: Integer;
        MileageAllowanceLine: Integer;
        QuarterPerDiemLine: Integer;
        DSAline: Integer;
        MemoLineApp: record "Imprest Memo Lines";
        OtherAllowanceDesc: Text[100];

        TotalGrandTotal: Decimal;
        TotalGrandonce: Decimal;
        TotalGrandTwice: Decimal;






    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  //EXIT(Users."Full Name");
        //  EXIT(Users."User Name");
        exit(UserCode);
    end;
}