codeunit 51804 "Motorpool Management"
{
    // version THL- PRM 1.0
    trigger OnRun()
    begin
    end;
    var Apportionment: Record "Cost Apportionment";
    Costs: Record "Motorpool Cost";
    CostCenter: Record "Motorpool Cost Centers";
    Matrix: Record "Motorpool Cost Matrix";
    Matrix2: Record "Motorpool Cost Matrix";
    Vehicles: Record Vehicle;
    Window: Dialog;
    Names: Text;
    Counter: Integer;
    procedure SuggestCostAnalysis(var Header: Record "Motorpool Cost Header")
    begin
        Header.CalcFields("Total Monthly Expenses");
        if Header."Total Monthly Expenses" = 0 then Error('You have not apportioned the total monthly costs!');
        Header.TestField(Period);
        Window.Open('Suggesting Costs Distribution for #####1', Names);
        Apportionment.Reset;
        Apportionment.SetRange(Period, Header.Period);
        if Header."Global Dimension 1 Code" <> '' then Apportionment.SetRange("Global Dimension 1 Code", Header."Global Dimension 1 Code");
        if Header."Global Dimension 2 Code" <> '' then Apportionment.SetRange("Global Dimension 2 Code", Header."Global Dimension 2 Code");
        if Apportionment.FindSet then begin
            repeat //Search through Apportionments
 Window.Update(1, Apportionment.Description);
                if Costs.Get(Apportionment.Cost)then begin //For each Apportionment, fetch the Cost Record
                    if Costs."Cost Analysis" = Costs."Cost Analysis"::"Per Cost Center" then begin //1. Per Cost Center
                        CostCenter.Reset;
                        if Header."Global Dimension 1 Code" <> '' then CostCenter.SetRange("Global Dimension 1 Code", Header."Global Dimension 1 Code");
                        if Header."Global Dimension 2 Code" <> '' then CostCenter.SetRange("Global Dimension 2 Code", Header."Global Dimension 2 Code");
                        if Header."Global Dimension 1 Code" <> '' then CostCenter.SetFilter("Global Dimension 1 Filter", Header."Global Dimension 1 Code");
                        if Header."Global Dimension 2 Code" <> '' then CostCenter.SetFilter("Global Dimension 2 Filter", Header."Global Dimension 2 Code");
                        if CostCenter.FindSet then begin
                            repeat //Get Each Cost Center under the Cost
 if Costs."Distribution Method" = Costs."Distribution Method"::"Based on Electronic Footprint" then begin //Electronic Footprint
                                    if CostCenter."Cost Ctr Electronic Footprint" <> 0 then begin
                                        if CostCenter."Total Electronic Footprint" = 0 then Error('The Total Electronic Footprint for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                        //Delete Existing
                                        /*Matrix2.RESET;
                                        Matrix2.SETRANGE("Vehicle No.",'');
                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                        Matrix2.SETRANGE(Period,Period);
                                        Matrix2.DELETEALL;*/
                                        //Insert New
                                        Matrix.Init;
                                        Matrix."Vehicle No.":='';
                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                        Matrix.Period:=Header.Period;
                                        Matrix."Cost Code":=Costs.Code;
                                        Matrix.Description:=Costs.Description;
                                        Matrix.Amount:=Round(CostCenter."Cost Ctr Electronic Footprint" / CostCenter."Total Electronic Footprint" * Apportionment."Total Amount Spent", 0.01);
                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                        else
                                        begin
                                            //Modify Existing if any
                                            Matrix2.Description:=Costs.Description;
                                            Matrix2.Amount:=Round(CostCenter."Cost Ctr Electronic Footprint" / CostCenter."Total Electronic Footprint" * Apportionment."Total Amount Spent", 0.01);
                                            Matrix2.Modify;
                                        end;
                                    end;
                                end; //Electronic Footprint****
                                if Costs."Distribution Method" = Costs."Distribution Method"::"Based on Mileage" then begin //Mileage
                                    CostCenter.SetFilter("Date Filter", '%1..%2', Header.Period, CalcDate('1M', Header.Period) - 1);
                                    CostCenter.CalcFields("Total Mileage");
                                    CostCenter.CalcFields("Cost Center Mileage");
                                    if CostCenter."Cost Center Mileage" <> 0 then begin
                                        if CostCenter."Total Mileage" = 0 then Error('The Total Mileage for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                        //Delete Existing
                                        /*Matrix2.RESET;
                                        Matrix2.SETRANGE("Vehicle No.",'');
                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                        Matrix2.SETRANGE(Period,Period);
                                        Matrix2.DELETEALL;*/
                                        //Insert New
                                        Matrix.Init;
                                        Matrix."Vehicle No.":='';
                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                        Matrix.Period:=Header.Period;
                                        Matrix."Cost Code":=Costs.Code;
                                        Matrix.Description:=Costs.Description;
                                        //MESSAGE('Cost Center Mileage: %1, Total Mileage: %2',CostCenter."Cost Center Mileage",CostCenter."Total Mileage");
                                        Matrix.Amount:=Round(CostCenter."Cost Center Mileage" / CostCenter."Total Mileage" * Apportionment."Total Amount Spent", 0.01);
                                        //MESSAGE('%1 - %2',Matrix.Description,FORMAT(Matrix.Amount));
                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                        else
                                        begin
                                            //Modify Existing if any
                                            Matrix2.Description:=Costs.Description;
                                            CostCenter.CalcFields("Total Mileage");
                                            CostCenter.CalcFields("Cost Center Mileage");
                                            Matrix2.Amount:=Round(CostCenter."Cost Center Mileage" / CostCenter."Total Mileage" * Apportionment."Total Amount Spent", 0.01);
                                            Matrix2.Modify;
                                        end;
                                    end;
                                end; //Mileage****
                                if Costs."Distribution Method" = Costs."Distribution Method"::"Based on office Space Covered" then begin //Office Space
                                    if CostCenter."Cost Center Office Space" <> 0 then begin
                                        if CostCenter."Total Office Space" = 0 then Error('The Total Office Space for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                        //Delete Existing
                                        /*Matrix2.RESET;
                                        Matrix2.SETRANGE("Vehicle No.",'');
                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                        Matrix2.SETRANGE(Period,Period);
                                        Matrix2.DELETEALL;*/
                                        //Insert New
                                        Matrix.Init;
                                        Matrix."Vehicle No.":='';
                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                        Matrix.Period:=Header.Period;
                                        Matrix."Cost Code":=Costs.Code;
                                        Matrix.Description:=Costs.Description;
                                        Matrix.Amount:=Round(CostCenter."Cost Center Office Space" / CostCenter."Total Office Space" * Apportionment."Total Amount Spent", 0.01);
                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                        else
                                        begin
                                            //Modify Existing if any
                                            Matrix2.Description:=Costs.Description;
                                            Matrix2.Amount:=Round(CostCenter."Cost Center Office Space" / CostCenter."Total Office Space" * Apportionment."Total Amount Spent", 0.01);
                                            Matrix2.Modify;
                                        end;
                                    end;
                                end; //Office Space****
                                if Costs."Distribution Method" = Costs."Distribution Method"::"Based on Staff Numbers" then begin //Staff Numbers
                                    if CostCenter."Cost Center No. of Staff" <> 0 then begin
                                        if CostCenter."Total No. of Staff" = 0 then Error('The Total No. of Staff for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                        //Delete Existing
                                        /*Matrix2.RESET;
                                        Matrix2.SETRANGE("Vehicle No.",'');
                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                        Matrix2.SETRANGE(Period,Period);
                                        Matrix2.DELETEALL;*/
                                        //Insert New
                                        Matrix.Init;
                                        Matrix."Vehicle No.":='';
                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                        Matrix.Period:=Header.Period;
                                        Matrix."Cost Code":=Costs.Code;
                                        Matrix.Description:=Costs.Description;
                                        Matrix.Amount:=Round(CostCenter."Cost Center No. of Staff" / CostCenter."Total No. of Staff" * Apportionment."Total Amount Spent", 0.01);
                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                        else
                                        begin
                                            //Modify Existing if any
                                            Matrix2.Description:=Costs.Description;
                                            Matrix2.Amount:=Round(CostCenter."Cost Center No. of Staff" / CostCenter."Total No. of Staff" * Apportionment."Total Amount Spent", 0.01);
                                            Matrix2.Modify;
                                        end;
                                    end;
                                end; //Staff Numbers****
                            until CostCenter.Next = 0;
                        end; //Get Each Cost Center under the Cost****
                    end
                    else if Costs."Cost Analysis" = Costs."Cost Analysis"::"Per Vehicle" then begin //1. Per Cost Center****//2. Per Vehicle
                            Vehicles.Reset;
                            Vehicles.SetFilter("Date Filter", '%1..%2', Header.Period, CalcDate('1M', Header.Period) - 1);
                            if Vehicles.FindSet then begin
                                repeat //Finding Vehicles
 Vehicles.CalcFields("Covered Mileage");
                                    if Vehicles."Covered Mileage" <> 0 then begin //Vehicles With Mileage for the Cost Center
                                        CostCenter.Reset;
                                        if Header."Global Dimension 1 Code" <> '' then CostCenter.SetRange("Global Dimension 1 Code", Header."Global Dimension 1 Code");
                                        if Header."Global Dimension 2 Code" <> '' then CostCenter.SetRange("Global Dimension 2 Code", Header."Global Dimension 2 Code");
                                        if Header."Global Dimension 1 Code" <> '' then CostCenter.SetFilter("Global Dimension 1 Filter", Header."Global Dimension 1 Code");
                                        if Header."Global Dimension 2 Code" <> '' then CostCenter.SetFilter("Global Dimension 2 Filter", Header."Global Dimension 2 Code");
                                        if CostCenter.FindSet then begin
                                            repeat //Get Each Cost Center under the Cost
 if Costs."Distribution Method" = Costs."Distribution Method"::"Based on Electronic Footprint" then begin //Electronic Footprint
                                                    if CostCenter."Cost Ctr Electronic Footprint" <> 0 then begin
                                                        if CostCenter."Total Electronic Footprint" = 0 then Error('The Total Electronic Footprint for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                                        //Delete Existing
                                                        /*Matrix2.RESET;
                                                        Matrix2.SETRANGE("Vehicle No.",Vehicles."No.");
                                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                                        Matrix2.SETRANGE(Period,Period);
                                                        Matrix2.DELETEALL;*/
                                                        //Insert New
                                                        Matrix.Init;
                                                        Matrix."Vehicle No.":=Vehicles."No.";
                                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                                        Matrix.Period:=Header.Period;
                                                        Matrix."Cost Code":=Costs.Code;
                                                        Matrix.Description:=Costs.Description;
                                                        Matrix.Amount:=Round(CostCenter."Cost Ctr Electronic Footprint" / CostCenter."Total Electronic Footprint" * Apportionment."Total Amount Spent", 0.01);
                                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                                        else
                                                        begin
                                                            //Modify Existing if any
                                                            Matrix2.Description:=Costs.Description;
                                                            Matrix2.Amount:=Round(CostCenter."Cost Ctr Electronic Footprint" / CostCenter."Total Electronic Footprint" * Apportionment."Total Amount Spent", 0.01);
                                                            Matrix2.Modify;
                                                        end;
                                                    end;
                                                end; //Electronic Footprint****
                                                if Costs."Distribution Method" = Costs."Distribution Method"::"Based on Mileage" then begin //Mileage
                                                    CostCenter.SetFilter("Date Filter", '%1..%2', Header.Period, CalcDate('1M', Header.Period) - 1);
                                                    CostCenter.CalcFields("Total Mileage");
                                                    CostCenter.CalcFields("Cost Center Mileage");
                                                    if CostCenter."Cost Center Mileage" <> 0 then begin
                                                        if CostCenter."Total Mileage" = 0 then Error('The Total Mileage for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                                        //Delete Existing
                                                        /*Matrix2.RESET;
                                                        Matrix2.SETRANGE("Vehicle No.",Vehicles."No.");
                                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                                        Matrix2.SETRANGE(Period,Period);
                                                        Matrix2.DELETEALL;*/
                                                        //Insert New
                                                        Matrix.Init;
                                                        Matrix."Vehicle No.":=Vehicles."No.";
                                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                                        Matrix.Period:=Header.Period;
                                                        Matrix."Cost Code":=Costs.Code;
                                                        Matrix.Description:=Costs.Description;
                                                        CostCenter.CalcFields("Total Mileage");
                                                        CostCenter.CalcFields("Cost Center Mileage");
                                                        Matrix.Amount:=Round(CostCenter."Cost Center Mileage" / CostCenter."Total Mileage" * Apportionment."Total Amount Spent", 0.01);
                                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                                        else
                                                        begin
                                                            //Modify Existing if any
                                                            Matrix2.Description:=Costs.Description;
                                                            CostCenter.CalcFields("Total Mileage");
                                                            CostCenter.CalcFields("Cost Center Mileage");
                                                            Matrix2.Amount:=Round(CostCenter."Cost Center Mileage" / CostCenter."Total Mileage" * Apportionment."Total Amount Spent", 0.01);
                                                            Matrix2.Modify;
                                                        end;
                                                    end;
                                                end; //Mileage****
                                                if Costs."Distribution Method" = Costs."Distribution Method"::"Based on office Space Covered" then begin //Office Space
                                                    if CostCenter."Cost Center Office Space" <> 0 then begin
                                                        if CostCenter."Total Office Space" = 0 then Error('The Total Office Space for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                                        //Delete Existing
                                                        /*Matrix2.RESET;
                                                        Matrix2.SETRANGE("Vehicle No.",Vehicles."No.");
                                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                                        Matrix2.SETRANGE(Period,Period);
                                                        Matrix2.DELETEALL;*/
                                                        //Insert New
                                                        Matrix.Init;
                                                        Matrix."Vehicle No.":=Vehicles."No.";
                                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                                        Matrix.Period:=Header.Period;
                                                        Matrix."Cost Code":=Costs.Code;
                                                        Matrix.Description:=Costs.Description;
                                                        Matrix.Amount:=Round(CostCenter."Cost Center Office Space" / CostCenter."Total Office Space" * Apportionment."Total Amount Spent", 0.01);
                                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                                        else
                                                        begin
                                                            //Modify Existing if any
                                                            Matrix2.Description:=Costs.Description;
                                                            Matrix2.Amount:=Round(CostCenter."Cost Center Office Space" / CostCenter."Total Office Space" * Apportionment."Total Amount Spent", 0.01);
                                                            Matrix2.Modify;
                                                        end;
                                                    end;
                                                end; //Office Space****
                                                if Costs."Distribution Method" = Costs."Distribution Method"::"Based on Staff Numbers" then begin //Staff Numbers
                                                    if CostCenter."Cost Center No. of Staff" <> 0 then begin
                                                        if CostCenter."Total No. of Staff" = 0 then Error('The Total No. of Staff for %1 is zero, kindly check!', CostCenter."Global Dimension 1 Code" + ' ' + CostCenter."Global Dimension 2 Code");
                                                        //Delete Existing
                                                        /*Matrix2.RESET;
                                                        Matrix2.SETRANGE("Vehicle No.",Vehicles."No.");
                                                        Matrix2.SETRANGE("Global Dimension 1 Code",CostCenter."Global Dimension 1 Code");
                                                        Matrix2.SETRANGE("Global Dimension 2 Code",CostCenter."Global Dimension 2 Code");
                                                        Matrix2.SETRANGE(Period,Period);
                                                        Matrix2.DELETEALL;*/
                                                        //Insert New
                                                        Matrix.Init;
                                                        Matrix."Vehicle No.":=Vehicles."No.";
                                                        Matrix."Global Dimension 1 Code":=CostCenter."Global Dimension 1 Code";
                                                        Matrix."Global Dimension 2 Code":=CostCenter."Global Dimension 2 Code";
                                                        Matrix.Period:=Header.Period;
                                                        Matrix."Cost Code":=Costs.Code;
                                                        Matrix.Description:=Costs.Description;
                                                        Matrix.Amount:=Round(CostCenter."Cost Center No. of Staff" / CostCenter."Total No. of Staff" * Apportionment."Total Amount Spent", 0.01);
                                                        if(not Matrix2.Get(Matrix."Vehicle No.", CostCenter."Global Dimension 1 Code", CostCenter."Global Dimension 2 Code", Header.Period, Costs.Code)) and (Matrix.Amount <> 0)then Matrix.Insert
                                                        else
                                                        begin
                                                            //Modify Existing if any
                                                            Matrix2.Description:=Costs.Description;
                                                            Matrix2.Amount:=Round(CostCenter."Cost Center No. of Staff" / CostCenter."Total No. of Staff" * Apportionment."Total Amount Spent", 0.01);
                                                            Matrix2.Modify;
                                                        end;
                                                    end;
                                                end; //Staff Numbers****
                                            until CostCenter.Next = 0;
                                        end; //Get Each Cost Center under the Cost****
                                    end; //Vehicles With Mileage for the Cost Center****
                                until Vehicles.Next = 0;
                            end; //Finding Vehicles****
                        end; //2. Per Vehicle****
                end; //For each Apportionment, fetch the Cost Record***
            until Apportionment.Next = 0;
        end; //Search through Apportionments****
        Window.Close;
    end;
}
