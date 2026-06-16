table 51917 "HR Management Cue"
{
    Caption = 'Finance Management Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; Vendors; Integer)
        {
            CalcFormula = count(Vendor);
            Caption = 'Vendors';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Customers; Integer)
        {
            CalcFormula = count(Customer);
            Caption = 'Customers';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Leave Applications"; Integer)
        {
            CalcFormula = count("Leave Application" where(status = const(open)));
            Caption = 'Leave Applications';
            Editable = false;
            FieldClass = FlowField;
        }
        //Leave Pending Approval
        // Open,Released,"Pending Approval","Pending Prepayment",Rejected;
        field(5; "Leave Pending Approval"; Integer)
        {
            CalcFormula = count("Leave Application" where(status = const("Pending Approval")));
            Caption = 'Leave Pending Approval';
            Editable = false;
            FieldClass = FlowField;
        }
        // Released
        field(6; "Leave Released"; Integer)
        {
            CalcFormula = count("Leave Application" where(status = const(Released)));
            Caption = 'Leave Released';
            Editable = false;
            FieldClass = FlowField;
        }
        // Rejected
        field(7; "Leave Rejected"; Integer)
        {
            CalcFormula = count("Leave Application" where(status = const(Rejected)));
            Caption = 'Leave Rejected';
            Editable = false;
            FieldClass = FlowField;
        }
        // Pending Prepayment
        field(8; "Leave Pending Prepayment"; Integer)
        {
            CalcFormula = count("Leave Application" where(status = const("Pending Prepayment")));
            Caption = 'Leave Pending Prepayment';
            Editable = false;
            FieldClass = FlowField;
        }
        //all Leave Applications
        field(9; "All Leave Applications"; Integer)
        {
            CalcFormula = count("Leave Application");
            Caption = 'All Leave Applications';
            Editable = false;
            FieldClass = FlowField;
        }
        // Training Request 
        field(10; "Training Need"; Integer)
        {
            CalcFormula = count("Training Request");
            Caption = 'Training Need';
            Editable = false;
            FieldClass = FlowField;
        }
        //'Open,Released,Pending Approval,Pending Prepayment';
        field(11; "Training Request Appl"; Integer)
        {
            CalcFormula = count("Training Request" where(Status = const(Open)));
            Caption = 'Training Request Pending';
            Editable = false;
            FieldClass = FlowField;
        }
        // Released
        field(12; "Training Request Released"; Integer)
        {
            CalcFormula = count("Training Request" where(Status = const(Released)));
            Caption = 'Training Request Released';
            Editable = false;
            FieldClass = FlowField;
        }
        // Pending Approval
        field(13; "Training Request Pending"; Integer)
        {
            CalcFormula = count("Training Request" where(Status = const("Pending Approval")));
            Caption = 'Training Request Approval Pending';
            Editable = false;
            FieldClass = FlowField;
        }
        //Employee Appraisal (52015)
        field(14; "Employee Appraisal"; Integer)
        {
            CalcFormula = count("Employee Appraisal");
            Caption = 'Employee Appraisal';
            Editable = false;
            FieldClass = FlowField;
        }
        // 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Pending Comments Approval,Completed,Mid-Year Approval';
        // Open
        field(15; "Employee Appraisal Open"; Integer)
        {
            CalcFormula = count("Employee Appraisal" where(Status = const(Open)));
            Caption = 'Employee Appraisal Open';
            Editable = false;
            FieldClass = FlowField;
        }
        //Pending Approval
        field(16; "Employee Appraisal Pending"; Integer)
        {
            CalcFormula = count("Employee Appraisal" where(Status = const("Pending Approval")));
            Caption = 'Employee Appraisal Pending Approval';
            Editable = false;
            FieldClass = FlowField;
        }
        //Released
        field(17; "Employee Appraisal Released"; Integer)
        {
            CalcFormula = count("Employee Appraisal" where(Status = const(Released)));
            Caption = 'Employee Appraisal Released';
            Editable = false;
            FieldClass = FlowField;
        }
        // Recruitment Needs
        // Recruitment Request List
        field(18; "Recruitment Need"; Integer)
        {
            CalcFormula = count("Recruitment Needs" where(Status = const(Open)));
            Caption = 'Recruitment Request List';
            Editable = false;
            FieldClass = FlowField;
        }
        //Approved Recruitment Requests 
        field(19; "Recruitment Need Approved"; Integer)
        {
            CalcFormula = count("Recruitment Needs" where(Status = const(Released)));
            Caption = ' Recruitment ongoing List';
            Editable = false;
            FieldClass = FlowField;
        }

        field(20; "Recruitment Need Closed"; Integer)
        {
            CalcFormula = count("Recruitment Needs" where(Status = const(closed)));
            Caption = ' Recruitment Closed List';
            Editable = false;
            FieldClass = FlowField;
        }
        // Applicant Submit-All (58985, List)
        field(21; "Applicant Submit-All"; Integer)
        {
            CalcFormula = count(Applicant where(Submitted = const(true)));
            Caption = 'Applicant Submit-All';
            Editable = false;
            FieldClass = FlowField;
        }




    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
