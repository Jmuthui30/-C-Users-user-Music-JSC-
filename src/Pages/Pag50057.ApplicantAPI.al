page 50057 "Applicant API"
{
    APIGroup = 'Applicant';
    APIPublisher = 'TeknohubDeveloper';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'ApplicantAPI';
    DelayedInsert = true;
    EntityName = 'ApplicantAPI';
    EntitySetName = 'ApplicantAPIs';
    PageType = API;
    SourceTable = Applicant;
    ODataKeyFields = SystemId;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(firstName; Rec."First Name")
                {
                    Caption = 'First Name';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Middle Name';
                }
                field(lastName; Rec."Last Name")
                {
                    Caption = 'Last Name';
                }
                field(birthDate; Rec."Birth Date")
                {
                    Caption = 'Birth Date';
                }
                field(age; Rec.Age)
                {
                    Caption = 'Age';
                }
                field(applicantType; Rec."Applicant Type")
                {
                    Caption = 'Applicant Type';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(disability; Rec.Disability)
                {
                    Caption = 'Disability';
                }
                field(disabilityDescription; Rec."Disability Description")
                {
                    Caption = 'Description';
                }
                field(nationalID; Rec."National ID")
                {
                    Caption = 'ID No. (For Kenyans)';
                }
                field(nssfNo; Rec."NSSF No")
                {
                    Caption = 'NSSF No';
                }
                field(SHIFNo; Rec."SHIF No")
                {
                    Caption = 'SHIF No';
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                }
                field(altAddressCode; Rec."Alt. Address Code")
                {
                    Caption = 'Alt. Address Code';
                }
                field(altAddressEndDate; Rec."Alt. Address End Date")
                {
                    Caption = 'Alt. Address End Date';
                }
                field(altAddressStartDate; Rec."Alt. Address Start Date")
                {
                    Caption = 'Alt. Address Start Date';
                }
                field(alternativePhoneNo; Rec."Alternative Phone No.")
                {
                    Caption = 'Alternative Phone No.';
                }
                field(annualGrossSalary; Rec."Annual Gross Salary")
                {
                    Caption = 'Annual Gross Salary';
                }
                field(annualLeaveDays; Rec."Annual Leave Days")
                {
                    Caption = 'Annual Leave Days';
                }
                field(applicationLetter; Rec."Application Letter")
                {
                    Caption = 'Application Letter';
                }
                field(causeOfInactivityCode; Rec."Cause of Inactivity Code")
                {
                    Caption = 'Cause of Inactivity Code';
                }
                field(certificateOfAdmission; Rec."Certificate of Admission")
                {
                    Caption = 'Certificate of Admission to the Roll of Advocates (Where Applicable)';
                }
                field(closingTime; Rec."Closing Time")
                {
                    Caption = 'Closing Time';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(companyEMail; Rec."Company E-Mail")
                {
                    Caption = 'Company Email';
                }
                field(contractTerminationNotice; Rec."Contract Termination Notice")
                {
                    Caption = 'Contract Termination Notice';
                }
                field(contractType; Rec."Contract Type")
                {
                    Caption = 'Contract Type';
                }
                field(costCenterCode; Rec."Cost Center Code")
                {
                    Caption = 'Cost Center Code';
                }
                field(costObjectCode; Rec."Cost Object Code")
                {
                    Caption = 'Cost Object Code';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(createdDate; Rec."Created Date")
                {
                    Caption = 'Created Date';
                }
                field(criminalDeclSpecification; Rec."Criminal Decl. Specification")
                {
                    Caption = 'Please Give Details of the case and any penalty for each offence';
                }
                field(criminalDeclaration; Rec."Criminal Declaration")
                {
                    Caption = 'Have you ever been convicted of, or cautioned for, any criminal offence or are any other proceedings pending against you?';
                }
                field(currentSalary; Rec."Current Salary")
                {
                    Caption = 'Current Salary';
                }
                field(currentExpectedSalary; Rec."Current/Expected Salary")
                {
                    Caption = 'Current/Expected Salary';
                }
                field(curriculumVitae; Rec."Curriculum Vitae")
                {
                    Caption = 'Curriculum Vitae';
                }
                field(daysWorkedPerWeek; Rec."Days Worked Per Week")
                {
                    Caption = 'Days Worked Per Week';
                }
                field(declarationDate; Rec."Declaration Date")
                {
                    Caption = 'Date (dd-mm-yyyy)';
                }
                field(dismissalDeclSpecification; Rec."Dismissal Decl. Specification")
                {
                    Caption = 'Please Give Details';
                }
                field(dismissalDeclaration; Rec."Dismissal Declaration")
                {
                    Caption = 'Have you ever been dismissed or otherwise removed from the Judicial service, Public Service or other engagement?';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(employmentDate; Rec."Employment Date")
                {
                    Caption = 'Employment Date';
                }
                field(emplymtContractCode; Rec."Emplymt. Contract Code")
                {
                    Caption = 'Emplymt. Contract Code';
                }
                field(ethnicGroup; Rec."Ethnic Group")
                {
                    Caption = 'Ethnic Group';
                }
                field(exitInterviewDate; Rec."Exit Interview Date")
                {
                    Caption = 'Exit Interview Date';
                }
                field(exitInterviewDoneBy; Rec."Exit Interview Done By")
                {
                    Caption = 'Exit Interview Done By';
                }
                field(expectedSalary; Rec."Expected Salary")
                {
                    Caption = 'Expected Salary';
                }
                field(extension; Rec.Extension)
                {
                    Caption = 'Extension';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(finalDeclaration; Rec."Final Declaration")
                {
                    Caption = 'I certify that the particulars given on this form are correct and understand that any incorrect/misleading information may lead to disqualification/ legal action ';
                }
                field(fullPartTime; Rec."Full / Part Time")
                {
                    Caption = 'Full / Part Time';
                }
                field(gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field(genderSpecification; Rec."Gender Specification")
                {
                    Caption = 'Gender Specification';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(globalDimension3Code; Rec."Global Dimension 3 Code")
                {
                    Caption = 'Global Dimension 3 Code';
                }
                field(groundsForTermCode; Rec."Grounds for Term. Code")
                {
                    Caption = 'Grounds for Term. Code';
                }
                field(helbNo; Rec."HELB No")
                {
                    Caption = 'HELB No';
                }
                field(highestLevelOfEducation; Rec."Highest Level Of Education")
                {
                    Caption = 'Highest Level Of Education';
                }
                field(homeCounty; Rec."Home County")
                {
                    Caption = 'Home County';
                }
                field(hoursWorkedPerWeek; Rec."Hours Worked Per Week")
                {
                    Caption = 'Hours Worked Per Week';
                }
                field(identificationDocument; Rec."Identification Document")
                {
                    Caption = 'National ID/Other Legal Identification Document';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(inactiveDate; Rec."Inactive Date")
                {
                    Caption = 'Inactive Date';
                }
                field(initials; Rec.Initials)
                {
                    Caption = 'Initials';
                }
                field(interview; Rec.Interview)
                {
                    Caption = 'Interview';
                }
                field(jobID; Rec."Job ID")
                {
                    Caption = 'Job ID';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(leaveNoticePeriod; Rec."Leave Notice Period")
                {
                    Caption = 'Leave Notice Period';
                }
                field(linkedIn; Rec.LinkedIn)
                {
                    Caption = 'LinkedIn';
                }
                field(lunchBreakDuration; Rec."Lunch Break Duration")
                {
                    Caption = 'Lunch Break Duration';
                }
                field(lunchEndTime; Rec."Lunch End Time")
                {
                    Caption = 'Lunch End Time';
                }
                field(lunchStartTime; Rec."Lunch Start Time")
                {
                    Caption = 'Lunch Start Time';
                }
                field(managerNo; Rec."Manager No.")
                {
                    Caption = 'Manager No.';
                }
                field(maritalStatus; Rec."Marital Status")
                {
                    Caption = 'Marital Status';
                }
                field(mediacalExamination; Rec."Mediacal Examination")
                {
                    Caption = 'Examination Results';
                }
                field(ncpwdCertificateNo; Rec."NCPWD Certificate No.")
                {
                    Caption = 'NCPWD Certificate No.';
                }
                field(nationality; Rec.Nationality)
                {
                    Caption = 'Nationality';
                }
                field(nationalitySpecification; Rec."Nationality Specification")
                {
                    Caption = 'Nationality Specification';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(offerSignedBy; Rec."Offer Signed By")
                {
                    Caption = 'Offer Signed By';
                }
                field(offerStatus; Rec."Offer Status")
                {
                    Caption = 'Offer Status';
                }
                field(officeLocation; Rec."Office Location")
                {
                    Caption = 'Office Location';
                }
                field(pager; Rec.Pager)
                {
                    Caption = 'Pager';
                }
                field(passportExpiryDate; Rec."Passport Expiry Date")
                {
                    Caption = 'Passport Expiry Date';
                }
                field(passportIssueDate; Rec."Passport Issue Date")
                {
                    Caption = 'Passport Issue Date';
                }
                field(passportNo; Rec."Passport No.")
                {
                    Caption = 'Passport No.';
                }
                field(passportPhoto; Rec."Passport Photo")
                {
                    Caption = 'Passport Photo (Optional)';
                }
                field(paysTax; Rec."Pays Tax")
                {
                    Caption = 'Pays Tax';
                }
                field(permitIssueDate; Rec."Permit Issue Date")
                {
                    Caption = 'Permit Issue Date';
                }
                field(permitNo; Rec."Permit No.")
                {
                    Caption = 'Permit No.';
                }
                field(permitValidityPeriod; Rec."Permit Validity Period")
                {
                    Caption = 'Permit Validity Period';
                }
                field(physicalAddress; Rec."Physical Address")
                {
                    Caption = 'Address 2';
                }
                field(picture; Rec.Picture)
                {
                    Caption = 'Picture';
                }
                field(portalID; Rec."Portal ID")
                {
                    Caption = 'Portal ID';
                }
                field(positionAppliedFor; Rec."Position Applied For")
                {
                    Caption = 'Position Applied For';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(postalAddress; Rec."Postal Address")
                {
                    Caption = 'Address';
                }
                field(probationPeriod; Rec."Probation Period")
                {
                    Caption = 'Probation Period';
                }
                field(probationTerminationNotice; Rec."Probation Termination Notice")
                {
                    Caption = 'Probation Termination Notice';
                }
                field(profession; Rec.Profession)
                {
                    Caption = 'Profession';
                }
                field(reportingTime; Rec."Reporting Time")
                {
                    Caption = 'Reporting Time';
                }
                field(resourceNo; Rec."Resource No.")
                {
                    Caption = 'Resource No.';
                }
                field(salaryCurrency; Rec."Salary Currency")
                {
                    Caption = 'Salary Currency';
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    Caption = 'Salespers./Purch. Code';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(shortlisting; Rec.Shortlisting)
                {
                    Caption = 'Shortlisting';
                }
                field(signature; Rec.Signature)
                {
                    Caption = 'Signature of Applicant (Upload scanned signature)';
                }
                field(socialSecurityNo; Rec."Social Security No.")
                {
                    Caption = 'Social Security No.';
                }
                field(staffID; Rec."Staff ID")
                {
                    Caption = 'Staff ID';
                }
                field(staffNo; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                }
                field(statisticsGroupCode; Rec."Statistics Group Code")
                {
                    Caption = 'Statistics Group Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(terminationDate; Rec."Termination Date")
                {
                    Caption = 'Termination Date';
                }
                field(testimonials; Rec.Testimonials)
                {
                    Caption = 'Testimonials';
                }
                field(title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(totalAbsenceBase; Rec."Total Absence (Base)")
                {
                    Caption = 'Total Absence (Base)';
                }
                field(totalInterviewMarks; Rec."Total Interview Marks")
                {
                    Caption = 'Total Interview Marks';
                }
                field(unionCode; Rec."Union Code")
                {
                    Caption = 'Union Code';
                }
                field(unionMembershipNo; Rec."Union Membership No.")
                {
                    Caption = 'Union Membership No.';
                }
                field(vacancyNo; Rec."Vacancy No.")
                {
                    Caption = 'Vacancy No.';
                }
                field(weekEndDay; Rec."Week End Day")
                {
                    Caption = 'Week End Day';
                }
                field(weekStartDay; Rec."Week Start Day")
                {
                    Caption = 'Week Start Day';
                }
                field(yearsOfExperience; Rec."Years Of Experience")
                {
                    Caption = 'Years Of Experience';
                }
                field(yearsOfRelevantExperience; Rec."Years Of Relevant Experience")
                {
                    Caption = 'Years Of Relevant Experience';
                }
            }
        }
    }
}
