report 59001 "Imprest Notification"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = imprestNotification;

    dataset
    {
        //    Payments
        dataitem(payments; payments)
        {
            DataItemTableView = sorting("No.") where("No." = const(''));
            column(No; "No.")
            {
            }
            //"Recipient Email"
            column(RecipientEmail; Email)
            {
            }
            // trigger OnAfterGetRecord()
            // begin
            //     CompInfo.Get;
            //     Humansetup.Get();

            //     TempBlob.CreateOutStream(OutStr);
            //     if payments."Surrender Email Date" = Today then begin

            //         VarEmail := payments.Email;

            //         // Staff Email Body
            //         Body := 'Dear ' + "Account Name" + ',';
            //         Body += '<br><br>';
            //         // Body += '<b>Kindly note that this notification is for testing purposes only. No action is required.</b>';
            //         Body += '<br><br>';
            //         Body += 'Kindly submit your Imperst allocated to you Imprest No : <b>' + InternalMemo."No." + '</b>.';
            //         Body += '<br><br>';
            //         Body += 'The details are as follows:';
            //         body += '<br><br>';
            //         body += '<ul>';
            //         Body += '<li><b>Imprest No:</b> ' + InternalMemo."Payment Narration" + '</li>';
            //         Body += '<li><b>Imprest Date:</b> ' + Format(InternalMemo."Date") + '</li>';
            //         Body += '<li><b> Amount :</b> ' + Format(InternalMemo."Total Amount") + '</li>';
            //         Body += '</ul>';

            //         Body += '<br><br>';



            //         Body += '</ul>';
            //         Body += '<br><br>';
            //         Body += '<b>Please Note:</b> The Microsoft Dynamics Self Service reference for this memo is <b>' + InternalMemo."No." + '</b>.';
            //         Body += '<br><br>';
            //         Body += 'Should you have any questions, please do not hesitate to contact the undersigned.';
            //         Body += '<br><br>';
            //         Body += 'Thank you.';
            //         Body += '<br><br>';
            //         Body += 'Yours sincerely,';
            //         Body += '<br><br>';
            //         Body += '<b>Business Central Notification System</b>';
            //         Body += '<br>';
            //         Body += CompInfo.Name;
            //         Body += '<br>';
            //         Mail.Create(VarEmail, InternalMemo."Payment Narration", Body, true);
            //         Mail.AddAttachment(PdfFileName, 'application/pdf', InStr);

            //         EmailReg.Send(Mail);

            //         payments."Imprest Email" := true;
            //         payments.Modify();
            //     end;
            // end;


            trigger OnAfterGetRecord()
            begin
                CompInfo.Get();
                Humansetup.Get();

                if "Surrender Email Date" <> Today then
                    exit;

                if Email = '' then
                    exit;

                VarEmail := Email;

                // //Generate PDF
                // TempBlob.CreateOutStream(OutStr);
                // Report.SaveAs(
                //     Report::"Imprest Notification",
                //     '',
                //     ReportFormat::Pdf,
                //     OutStr,
                //     Rec);

                TempBlob.CreateInStream(InStr);
                PdfFileName := 'Imprest_' + "No." + '.pdf';

                //Email Body
                Body := 'Dear ' + "Account Name" + ',';
                Body += '<br/><br/>';
                Body += 'This is a reminder to submit your <b>Imprest Surrender</b>.';
                Body += '<br/><br/>';

                Body += '<table border="1" cellpadding="4" cellspacing="0">';
                Body += '<tr><td><b>Imprest No.</b></td><td>' + "No." + '</td></tr>';
                Body += '<tr><td><b>Description</b></td><td>' + "Payment Narration" + '</td></tr>';
                Body += '<tr><td><b>Date</b></td><td>' + Format(Date) + '</td></tr>';
                Body += '<tr><td><b>Amount</b></td><td>' + Format("Total Amount") + '</td></tr>';
                Body += '</table>';

                Body += '<br/><br/>';
                Body += 'Please submit the surrender at your earliest convenience.';
                Body += '<br/><br/>';
                Body += 'Thank you.';
                Body += '<br/><br/>';
                Body += 'Yours sincerely,';
                Body += '<br/><br/>';
                Body += '<b>Business Central Notification System</b>';
                Body += '<br/>' + CompInfo.Name;

                Mail.Create(
                    VarEmail,
                    'Imprest Surrender Reminder - ' + "No.",
                    Body,
                    true);

                // Mail.AddAttachment(PdfFileName, 'application/pdf', InStr);

                EmailReg.Send(Mail);

                "Imprest Email" := true;
                Modify();
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
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {

            }
        }
    }

    rendering
    {
        layout(imprestNotification)
        {
            // Specify the layout type and the path to the layout file
            Type = RDLC;
            LayoutFile = './Reports/SSRS/ImprestNotification.rdlc';
        }

    }

    var
        myInt: Integer;
        Lines: Record "Imprest Memo Lines";
        BCLink: Text;
        ImprestHeader: Record Payments;
        EmployeeRecord: Record Employee;
        TotalAmount: Decimal;
        VarTotalAmount: Decimal;
        VarEmail: Text[100];
        Humansetup: Record "Human Resources Setup";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        PdfFileName: Text;
        MailBody: Text;
        RecordRefVar: RecordRef;
        LocalCustomer: Record Payments;
        EmailReg: Codeunit Email;
        Body: Text;
        CompInfo: Record "Company Information";
        InternalMemo: Record payments;
        Mail: Codeunit "Email Message";
}