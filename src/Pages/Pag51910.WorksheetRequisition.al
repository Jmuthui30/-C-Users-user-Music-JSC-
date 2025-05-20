page 51910 "Worksheet Requisition"
{
    Caption = 'MTF3 Lines';
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Worksheet Requisitions Lines";
    SourceTableView = WHERE(Status=FILTER(Open|"Pending Approval"|Released), Posted=CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RegisterStyle;
                }
                field("Store Req. Status"; Rec."Store Req. Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RegisterStyle;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;

                    trigger OnValidate()
                    begin
                        if(Rec.Type = Rec.Type::"G/L Account") and (Rec.Status = Rec.Status::Open)then costEditable:=true
                        else
                            costEditable:=false;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RegisterStyle;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;
                }
                field("Working Date"; Rec."Working Date")
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Enabled = costEditable;
                    StyleExpr = RegisterStyle;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RegisterStyle;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;
                    Visible = false;
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RegisterStyle;
                }
                field("Quantity Unissued"; Rec."Quantity Unissued")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RegisterStyle;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RegisterStyle;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Code';
                    Editable = false;
                    ShowMandatory = true;
                    StyleExpr = RegisterStyle;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RegisterStyle;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Send For Approval")
                {
                    AccessByPermission = TableData "Extended Text Header"=R;
                    ApplicationArea = Service;
                    Caption = 'Send For Approval';
                    Image = SendApprovalRequest;
                    ToolTip = 'Send For Approval Request';

                    trigger OnAction()
                    begin
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat //Do your action here
                                Rec.TestField(Rec.Status, Rec.Status::Open);
                                Rec.TestField(Rec.Quantity);
                                If Rec.Type = Rec.Type::Item Then Rec.TestField("Location Code");
                                Rec.TestField("Shortcut Dimension 1 Code");
                                Rec.TestField("Raised by", UserId);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat //Do your action here
                                ApprovalsMgmtExt.OnSendJobWorksheetForApproval(WorksheetRequisitionsLines);
                            /*Rec.Status := Rec.Status::Released;
                            Modify(true);*/
                            //MTF3Approval.OnSendMTF3ForApproval(Rec);
                            //InCodeUnitApproval.OnSendMTF3ForApproval(Rec);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    AccessByPermission = TableData "Extended Text Header"=R;
                    ApplicationArea = Service;
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel Send For Approval Request';

                    trigger OnAction()
                    begin
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat //Do your action here
                                Rec.TestField(Status, Rec.Status::"Pending Approval");
                                Rec.TestField("Raised by", UserId);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat //Do your action here
                                ApprovalsMgmtExt.OnCancelJobWorksheetApprovalRequest(WorksheetRequisitionsLines);
                            //InCodeUnitApproval.OnCancelMTF3ApprovalRequest(Rec);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                    end;
                }
                action("Send Store Requisition")
                {
                    ApplicationArea = Service;
                    Caption = 'Send Store Requisition';
                    Image = Post;

                    trigger OnAction()
                    var
                        DocNo: Code[20];
                        Counter: Integer;
                        Global1: Code[20];
                        Global2: Code[20];
                        JobNo: Code[20];
                        JobTaskNo: Code[20];
                        JobDes: Text[100];
                    begin
                        //Field Validate
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat Rec.TestField(Status, WorksheetRequisitionsLines.Status::Released);
                                Rec.TestField(Type, WorksheetRequisitionsLines.Type::Item);
                                Rec.TestField(Posted, false);
                                Rec.TestField("Store Req. Status", false);
                            //TESTFIELD("Raised by", USERID);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        //Dimensions
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindFirst then begin
                            Global1:=WorksheetRequisitionsLines."Shortcut Dimension 1 Code";
                            JobNo:=WorksheetRequisitionsLines."Job No.";
                            JobTaskNo:=WorksheetRequisitionsLines."Job Task No.";
                            JobDes:=CopyStr(WorksheetRequisitionsLines."Job Description", 1, 100);
                        end;
                        //Create Requisition Header
                        ProcurementSetup.Get;
                        RequisitionHeader.Init;
                        RequisitionHeader.Status:=RequisitionHeader.Status::Released;
                        RequisitionHeader."Requisition Type":=RequisitionHeader."Requisition Type"::"J_Store Requisition";
                        RequisitionHeader."Job No.":=JobNo;
                        RequisitionHeader."Job Task No.":=JobTaskNo;
                        RequisitionHeader."Job Description":=JobDes;
                        RequisitionHeader."Raised by":=UserId;
                        RequisitionHeader."Global Dimension 1 Code":=Global1;
                        RequisitionHeader.Validate("Global Dimension 1 Code");
                        RequisitionHeader."Document Type":=RequisitionHeader."Document Type"::"Store Requisition";
                        if QuantumJumpsUserSetup.Get(UserId)then begin
                            RequisitionHeader."Employee Code":=QuantumJumpsUserSetup."Employee No.";
                            if Employee.Get(QuantumJumpsUserSetup."Employee No.")then RequisitionHeader."Employee Name":=Employee.FullName;
                        end;
                        RequisitionHeader.Insert(true);
                        //Update Requisition Lines
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat //Do your action here
                                Counter:=Counter + 1000;
                                RequisitionLines.Init;
                                RequisitionLines."Requisition No":=RequisitionHeader."No.";
                                RequisitionLines."Line No":=Counter;
                                RequisitionLines.Status:=RequisitionLines.Status::Released;
                                RequisitionLines.Type:=RequisitionLines.Type::Item;
                                RequisitionLines.No:=WorksheetRequisitionsLines."No.";
                                if Item.Get(WorksheetRequisitionsLines."No.")then begin
                                    RequisitionLines.Amount:=WorksheetRequisitionsLines.Quantity * Item."Unit Cost";
                                    RequisitionLines."Quantity in Store":=Item.Inventory;
                                end;
                                RequisitionLines.Description:=WorksheetRequisitionsLines.Description;
                                RequisitionLines."Unit of Measure":=WorksheetRequisitionsLines."Unit of Measure Code";
                                RequisitionLines."Location Code":=WorksheetRequisitionsLines."Location Code";
                                RequisitionLines.Quantity:=WorksheetRequisitionsLines.Quantity;
                                RequisitionLines."Quantity Approved":=WorksheetRequisitionsLines.Quantity;
                                RequisitionLines."Job No":=WorksheetRequisitionsLines."Job No.";
                                RequisitionLines.Validate("Job No");
                                RequisitionLines."Job Task No":=WorksheetRequisitionsLines."Job Task No.";
                                RequisitionLines.Validate("Job Task No");
                                RequisitionLines."Global Dimension 1 Code":=WorksheetRequisitionsLines."Shortcut Dimension 1 Code";
                                RequisitionLines.Validate("Global Dimension 1 Code");
                                RequisitionLines."Global Dimension 2 Code":=WorksheetRequisitionsLines."Shortcut Dimension 2 Code";
                                RequisitionLines."Job Worksheet LineNo":=WorksheetRequisitionsLines."Line No.";
                                RequisitionLines.Insert(true);
                                WorksheetRequisitionsLines."Store Req. Status":=true;
                                WorksheetRequisitionsLines.Modify;
                            until WorksheetRequisitionsLines.Next = 0;
                            Global1:='';
                            Global2:='';
                            JobNo:='';
                            JobTaskNo:='';
                            JobDes:='';
                            Message('Job Store Requisition is Created');
                        end;
                    end;
                }
                action("Post Resource")
                {
                    AccessByPermission = TableData "Extended Text Header"=R;
                    ApplicationArea = Service;
                    Caption = 'Post Resource';
                    Image = Resource;
                    ToolTip = 'Post Resource';

                    trigger OnAction()
                    begin
                        //Validate Fields
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat Rec.TestField(Status, WorksheetRequisitionsLines.Status::Released);
                                Rec.TestField(Type, WorksheetRequisitionsLines.Type::Resource);
                                Rec.TestField(Posted, false);
                            //TESTFIELD("Raised by", USERID);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        //Post Resourse
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat OEE_Requisitions."Post Job Resource"(WorksheetRequisitionsLines);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        Message('Job Resource have been Posted');
                    end;
                }
                action("Post GL Account")
                {
                    AccessByPermission = TableData "Extended Text Header"=R;
                    ApplicationArea = Service;
                    Caption = 'Post GL Account';
                    Image = GL;
                    ToolTip = 'Post GL Account';

                    trigger OnAction()
                    begin
                        //Validate Fields
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat Rec.TestField(Status, WorksheetRequisitionsLines.Status::Released);
                                Rec.TestField(Type, WorksheetRequisitionsLines.Type::"G/L Account");
                                Rec.TestField(Posted, false);
                            //TESTFIELD("Raised by", USERID);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        //Post Resourse
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat OEE_Requisitions."Post Job GL"(WorksheetRequisitionsLines);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        Message('Job GL have been Posted');
                    end;
                }
                action("Approval Set Up")
                {
                    ApplicationArea = All;
                    Image = ApprovalSetup;
                    RunObject = Page "Self Service Approval Setup";
                }
                action("Re-Open")
                {
                    ApplicationArea = All;
                    Image = ReOpen;

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat //Do your action here
                                Rec.TestField(Status, Rec.Status::Released);
                                Rec.TestField("Raised by", UserId);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                        WorksheetRequisitionsLines.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(WorksheetRequisitionsLines);
                        if WorksheetRequisitionsLines.FindSet then begin
                            repeat //Do your action here
                                WorksheetRequisitionsLines.Status:=WorksheetRequisitionsLines.Status::Open;
                                WorksheetRequisitionsLines.Modify(true);
                            until WorksheetRequisitionsLines.Next = 0;
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //Style:
        RegisterStyle:='';
        if Rec.Status = Rec.Status::Open then RegisterStyle:='Ambiguous'
        else if Rec.Status = Rec.Status::"Pending Approval" then RegisterStyle:='StrongAccent'
            else if Rec.Status = Rec.Status::Released then RegisterStyle:='Unfavorable';
        if((Rec.Status = Rec.Status::Released) and (Rec.Posted = true))then RegisterStyle:='Favorable';
        if((Rec.Status = Rec.Status::Released) and (Rec.Quantity = Rec."Quantity Issued"))then RegisterStyle:='Favorable';
        if(Rec.Type = Rec.Type::"G/L Account") and (Rec.Status = Rec.Status::Open)then costEditable:=true
        else
            costEditable:=false;
    end;
    trigger OnAfterGetRecord()
    begin
        Rec."Quantity Unissued":=Rec.Quantity - Rec."Quantity Issued";
        /*IF "Quantity Unissued" = 0 THEN
          Posted := TRUE;
        */
        //Style:
        RegisterStyle:='';
        if Rec.Status = Rec.Status::Open then RegisterStyle:='Ambiguous'
        else if Rec.Status = Rec.Status::"Pending Approval" then RegisterStyle:='StrongAccent'
            else if Rec.Status = Rec.Status::Released then RegisterStyle:='Unfavorable';
        if((Rec.Status = Rec.Status::Released) and (Rec.Posted = true))then RegisterStyle:='Favorable';
        if((Rec.Status = Rec.Status::Released) and (Rec.Quantity = Rec."Quantity Issued"))then begin
            RegisterStyle:='Favorable';
            Rec.Posted:=true;
        end;
        if(Rec.Type = Rec.Type::"G/L Account") and (Rec.Status = Rec.Status::Open)then costEditable:=true
        else
            costEditable:=false;
    end;
    trigger OnModifyRecord(): Boolean begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField(Posted, false);
    end;
    trigger OnOpenPage()
    begin
    //SETRANGE("Raised by", USERID);
    end;
    var OEE_Requisitions: Codeunit 51805;
    ApprovalsMgmtExt: Codeunit "Approvals Mgmt. Ext";
    //MTF3Approval: Codeunit "MTF3 Approval";
    //InCodeUnitApproval: Codeunit "IntCodeunit Approval";
    JobTask: Record "Job Task";
    WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines";
    RequisitionHeader: Record "Requisition Header";
    ProcurementSetup: Record "Procurement Setup";
    RequisitionLines: Record "Requisition Lines";
    QuantumJumpsUserSetup: Record "User Setup";
    Employee: Record Employee;
    JobJnLine: Record "Job Journal Line";
    Batch: Record "Gen. Journal Batch";
    JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
    Item: Record Item;
    costEditable: Boolean;
    RegisterStyle: Text;
}
