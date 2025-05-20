codeunit 51601 "Performance Management"
{
    // version THL- HRM 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
    // Advanced Finance: 52100 - 52199 = 99
    // QuantumJumps HR: 51600 - 51799 = 199
    // QuantumJumps Procumement: 51800 - 51899 = 99
    // ***********************
    // EasyPFA: 51900 - 52099 = 199
    // Investment: 52100 - 52199 = 99
    // DynamicsHMIS: 52200 - 52299 = 99
    // EasyProperty: 52300 - 52399 = 99
    // Insurance: 61423 - 61622 = 199
    // Sacco:   61623 - 62422 = ***
    // ***********************
    trigger OnRun()
    begin
    end;
    var SubQ2: Record "Appraisal Sub-Questions";
    Text000: Label 'Completed Succesfully';
    Text001: Label 'You have reviewed all the questions and responses.';
    Text002: Label 'Ensure you have reviwed and made remarks on all responses before closing this appraisal process. Once this appraisal form is closed, you cannot make changes to it. Do you wish to continue?';
    Text003: Label 'You are about to archive this appraisal form. Do you wish to continue?';
    procedure InitializeQuestions(var Appraisal: Record "Performance Appraisal")
    var
        Q: Record "Appraisal Questions";
        SubQ: Record "Appraisal Sub-Questions";
        SubSubQ: Record "Appraisal Sub-Sub-Questions";
        QEntries: Record "Appraisal Questions Entries";
        SubQEntries: Record "Appraisal SubQuestions Entries";
        SubSubQEntries: Record "Sub SubQuestions Entries";
        QEntriesCopy: Record "Appraisal Questions Entries";
        SubQEntriesCopy: Record "Appraisal SubQuestions Entries";
        SubSubQEntriesCopy: Record "Sub SubQuestions Entries";
    begin
        //Initialize Main Questions
        Q.Reset;
        if Q.Find('-')then begin
            repeat QEntries.Init;
                QEntries."Employee No":=Appraisal."Employee No";
                QEntries."Review Start Date":=Appraisal."Review Start Date";
                QEntries."Review End Date":=Appraisal."Review End Date";
                QEntries."No.":=Q."No.";
                QEntries.Question:=Q.Question;
                QEntries."Further Explanation":=Q."Further Explanation";
                QEntries."Question Type":=Q."Question Type";
                QEntries."Sub-Question Instructions":=Q."Sub-Question Instructions";
                if not QEntriesCopy.Get(Appraisal."Employee No", Appraisal."Review Start Date", Appraisal."Review End Date", Q."No.")then QEntries.Insert
                else
                begin
                    QEntriesCopy.Question:=Q.Question;
                    QEntriesCopy."Further Explanation":=Q."Further Explanation";
                    QEntriesCopy."Question Type":=Q."Question Type";
                    QEntriesCopy."Sub-Question Instructions":=Q."Sub-Question Instructions";
                    QEntriesCopy.Modify;
                end;
            until Q.Next = 0;
        end;
        //
        //Initialize Sub Questions
        SubQ.Reset;
        if SubQ.Find('-')then begin
            repeat SubQEntries.Init;
                SubQEntries."Employee No":=Appraisal."Employee No";
                SubQEntries."Review Start Date":=Appraisal."Review Start Date";
                SubQEntries."Review End Date":=Appraisal."Review End Date";
                SubQEntries."Main Question No.":=SubQ."Main Question No.";
                SubQEntries."Sub-Question No.":=SubQ."Sub-Question No.";
                SubQEntries.Question:=SubQ.Question;
                SubQEntries."Further Explanation":=SubQ."Further Explanation";
                SubQEntries."Question Type":=SubQ."Question Type";
                SubQEntries."Sub-Question Instructions":=SubQ."Sub-Question Instructions";
                if(Q.Get(SubQ."Main Question No.")) and (not SubQEntriesCopy.Get(Appraisal."Employee No", Appraisal."Review Start Date", Appraisal."Review End Date", SubQ."Main Question No.", SubQ."Sub-Question No."))then SubQEntries.Insert
                else
                begin
                    SubQEntriesCopy.Question:=SubQ.Question;
                    SubQEntriesCopy."Further Explanation":=SubQ."Further Explanation";
                    SubQEntriesCopy."Question Type":=SubQ."Question Type";
                    SubQEntriesCopy."Sub-Question Instructions":=SubQ."Sub-Question Instructions";
                    SubQEntriesCopy.Modify;
                end;
            until SubQ.Next = 0;
        end;
        //
        //Initialize Sub-Sub Questions
        SubSubQ.Reset;
        if SubSubQ.Find('-')then begin
            repeat SubSubQEntries.Init;
                SubSubQEntries."Employee No":=Appraisal."Employee No";
                SubSubQEntries."Review Start Date":=Appraisal."Review Start Date";
                SubSubQEntries."Review End Date":=Appraisal."Review End Date";
                SubSubQEntries."Main Question No.":=SubSubQ."Main Question No.";
                SubSubQEntries."Sub-Question No.":=SubSubQ."Sub-Question No.";
                SubSubQEntries."Sub-Sub Question No.":=SubSubQ."Sub-Sub Question No.";
                SubSubQEntries.Question:=SubSubQ.Question;
                SubSubQEntries."Further Explanation":=SubSubQ."Further Explanation";
                if(SubQ.Get(SubSubQ."Main Question No.", SubSubQ."Sub-Question No.")) and (not SubSubQEntriesCopy.Get(Appraisal."Employee No", Appraisal."Review Start Date", Appraisal."Review End Date", SubSubQ."Main Question No.", SubSubQ."Sub-Question No.", SubSubQ."Sub-Sub Question No."))then SubSubQEntries.Insert
                else
                begin
                    SubSubQEntriesCopy.Question:=SubSubQ.Question;
                    SubSubQEntriesCopy."Further Explanation":=SubSubQ."Further Explanation";
                    SubSubQEntriesCopy.Modify;
                end;
            until SubSubQ.Next = 0;
        end;
    //
    end;
    procedure RespondToQuestions(var Appraisal: Record "Performance Appraisal")
    var
        QEntries: Record "Appraisal Questions Entries";
        SubQEntries: Record "Appraisal SubQuestions Entries";
        SubSubQEntries: Record "Sub SubQuestions Entries";
    begin
        QEntries.Reset;
        QEntries.SetRange("Employee No", Appraisal."Employee No");
        QEntries.SetRange("Review Start Date", Appraisal."Review Start Date");
        QEntries.SetRange("Review End Date", Appraisal."Review End Date");
        if QEntries.Find('-')then begin
            repeat //Get Main Question
                Commit;
                if PAGE.RunModal(PAGE::"SS Appraisee Question Response", QEntries) = ACTION::LookupOK then begin
                    if QEntries."Question Type" = QEntries."Question Type"::"Single Question" then begin
                        QEntries.TestField(Response);
                        QEntries.TestField("My Rating");
                    end
                    else
                    begin
                        //Get Sub Question
                        Commit;
                        SubQEntries.Reset;
                        SubQEntries.SetRange("Employee No", Appraisal."Employee No");
                        SubQEntries.SetRange("Review Start Date", Appraisal."Review Start Date");
                        SubQEntries.SetRange("Review End Date", Appraisal."Review End Date");
                        SubQEntries.SetRange("Main Question No.", QEntries."No.");
                        if SubQEntries.Find('-')then begin
                            repeat if PAGE.RunModal(PAGE::"SS Sub Question Responses", SubQEntries) = ACTION::LookupOK then begin
                                    if SubQEntries."Question Type" = SubQEntries."Question Type"::"Single Question" then begin
                                        QEntries.TestField(Response);
                                        QEntries.TestField("My Rating");
                                    end
                                    else
                                    begin
                                        Commit;
                                        //Get Sub-Sub Questions
                                        SubSubQEntries.Reset;
                                        SubSubQEntries.SetRange("Employee No", Appraisal."Employee No");
                                        SubSubQEntries.SetRange("Review Start Date", Appraisal."Review Start Date");
                                        SubSubQEntries.SetRange("Review End Date", Appraisal."Review End Date");
                                        SubSubQEntries.SetRange("Main Question No.", SubQEntries."Main Question No.");
                                        SubSubQEntries.SetRange("Sub-Question No.", SubQEntries."Sub-Question No.");
                                        if PAGE.RunModal(PAGE::"SS Sub-Sub Question Responses", SubSubQEntries) = ACTION::LookupOK then begin
                                        end;
                                        Commit;
                                    end;
                                end;
                            until SubQEntries.Next = 0;
                        end;
                    end;
                end;
                Commit;
            until QEntries.Next = 0;
        end;
        Message(Text000);
    end;
    procedure ReviewAppraiseeResponses(var Appraisal: Record "Performance Appraisal")
    var
        QEntries: Record "Appraisal Questions Entries";
        SubQEntries: Record "Appraisal SubQuestions Entries";
        SubSubQEntries: Record "Sub SubQuestions Entries";
    begin
        QEntries.Reset;
        QEntries.SetRange("Employee No", Appraisal."Employee No");
        QEntries.SetRange("Review Start Date", Appraisal."Review Start Date");
        QEntries.SetRange("Review End Date", Appraisal."Review End Date");
        if QEntries.Find('-')then begin
            repeat //Get Main Question
                Commit;
                if PAGE.RunModal(PAGE::"Appraisee Question Response", QEntries) = ACTION::LookupOK then begin
                    if QEntries."Question Type" = QEntries."Question Type"::"Single Question" then begin
                        QEntries.TestField(Response);
                        QEntries.TestField("My Rating");
                    end
                    else
                    begin
                        //Get Sub Question
                        Commit;
                        SubQEntries.Reset;
                        SubQEntries.SetRange("Employee No", Appraisal."Employee No");
                        SubQEntries.SetRange("Review Start Date", Appraisal."Review Start Date");
                        SubQEntries.SetRange("Review End Date", Appraisal."Review End Date");
                        SubQEntries.SetRange("Main Question No.", QEntries."No.");
                        if SubQEntries.Find('-')then begin
                            repeat if PAGE.RunModal(PAGE::"Sub Question Responses", SubQEntries) = ACTION::LookupOK then begin
                                    if SubQEntries."Question Type" = SubQEntries."Question Type"::"Single Question" then begin
                                        QEntries.TestField(Response);
                                        QEntries.TestField("My Rating");
                                    end
                                    else
                                    begin
                                        Commit;
                                        //Get Sub-Sub Questions
                                        SubSubQEntries.Reset;
                                        SubSubQEntries.SetRange("Employee No", Appraisal."Employee No");
                                        SubSubQEntries.SetRange("Review Start Date", Appraisal."Review Start Date");
                                        SubSubQEntries.SetRange("Review End Date", Appraisal."Review End Date");
                                        SubSubQEntries.SetRange("Main Question No.", SubQEntries."Main Question No.");
                                        SubSubQEntries.SetRange("Sub-Question No.", SubQEntries."Sub-Question No.");
                                        if PAGE.RunModal(PAGE::"Sub-Sub Question Responses", SubSubQEntries) = ACTION::LookupOK then begin
                                        end;
                                        Commit;
                                    end;
                                end;
                            until SubQEntries.Next = 0;
                        end;
                    end;
                end;
                Commit;
            until QEntries.Next = 0;
        end;
        Message(Text001);
    end;
    procedure CloseAppraisalForm(var Appraisal: Record "Performance Appraisal")
    var
        QEntries: Record "Appraisal Questions Entries";
        SubQEntries: Record "Appraisal SubQuestions Entries";
        SubSubQEntries: Record "Sub SubQuestions Entries";
    begin
        if Confirm(Text002, false) = true then begin
            Appraisal.Validate(Closed, true);
            Appraisal.Modify;
        end;
    end;
    procedure ArchiveAppraisalForm(var Appraisal: Record "Performance Appraisal")
    var
        QEntries: Record "Appraisal Questions Entries";
        SubQEntries: Record "Appraisal SubQuestions Entries";
        SubSubQEntries: Record "Sub SubQuestions Entries";
    begin
        if Confirm(Text003, false) = true then begin
            Appraisal.Validate(Archived, true);
            Appraisal.Modify;
        end;
    end;
    procedure CheckAppraisalFormQEditable(var QEntries: Record "Appraisal Questions Entries")Editable: Boolean var
        Appraisal: Record "Performance Appraisal";
    begin
        Editable:=true;
        if Appraisal.Get(QEntries."No.")then if Appraisal.Closed then Editable:=false;
        exit(Editable);
    end;
    procedure CheckAppraisalFormSubQEditable(var SubQEntries: Record "Appraisal SubQuestions Entries")Editable: Boolean var
        Appraisal: Record "Performance Appraisal";
    begin
        Editable:=true;
        if Appraisal.Get(SubQEntries."Main Question No.")then if Appraisal.Closed then Editable:=false;
        exit(Editable);
    end;
    procedure CheckAppraisalFormSubSubQEditable(var SubSubQEntries: Record "Sub SubQuestions Entries")Editable: Boolean var
        Appraisal: Record "Performance Appraisal";
    begin
        Editable:=true;
        if Appraisal.Get(SubSubQEntries."Main Question No.")then if Appraisal.Closed then Editable:=false;
        exit(Editable);
    end;
}
