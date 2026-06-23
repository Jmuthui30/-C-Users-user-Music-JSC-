codeunit 52398 "JSC Perf Framework Seeder"
{
    procedure SeedFramework()
    var
        AttributeCount: Integer;
        IndicatorCount: Integer;
        InitiativeCount: Integer;
        MatrixCount: Integer;
        MeasureCount: Integer;
        RatingCount: Integer;
        SkippedMappingCount: Integer;
        WorkplanCount: Integer;
    begin
        if not Confirm('Seed the June 2026 JSC performance framework setup data? This temporary action will upsert workplan codes, performance measures, rating bands, grade matrix entries, and competency setup.', false) then
            exit;

        SeedRatingScale(RatingCount);
        SeedGradeMatrix(MatrixCount);
        SeedCompetencies(AttributeCount, IndicatorCount);
        SeedWorkplansAndMeasures(WorkplanCount, MeasureCount, InitiativeCount, SkippedMappingCount);

        Message('JSC performance framework seed completed. Workplans touched: %1. Performance measures touched: %2. Default initiatives touched: %3. Rating scale entries touched: %4. Grade matrix entries touched: %5. Competency attributes touched: %6. Competency indicators touched: %7. Skipped mappings due missing Responsibility Center: %8.',
            WorkplanCount,
            MeasureCount,
            InitiativeCount,
            RatingCount,
            MatrixCount,
            AttributeCount,
            IndicatorCount,
            SkippedMappingCount);
    end;

    local procedure SeedWorkplansAndMeasures(var WorkplanCount: Integer; var MeasureCount: Integer; var InitiativeCount: Integer; var SkippedMappingCount: Integer)
    begin
        if UpsertWorkplan('HRM', 'Human Resource Management and Development', 'HRM', WorkplanCount, SkippedMappingCount) then begin
            SeedHumanResourceMeasures('HRM', MeasureCount);
            UpsertDefaultInitiative('HRM', InitiativeCount);
        end;
        if UpsertWorkplan('FIN', 'Finance, Accounts and Resource Mobilization', 'FIN', WorkplanCount, SkippedMappingCount) then begin
            SeedFinanceMeasures('FIN', MeasureCount);
            UpsertDefaultInitiative('FIN', InitiativeCount);
        end;
        if UpsertWorkplan('ACCOUNTS', 'Finance, Accounts and Resource Mobilization', 'ACCOUNTS', WorkplanCount, SkippedMappingCount) then begin
            SeedFinanceMeasures('ACCOUNTS', MeasureCount);
            UpsertDefaultInitiative('ACCOUNTS', InitiativeCount);
        end;
        if UpsertWorkplan('LEGAL', 'Legal Services', 'LEGAL', WorkplanCount, SkippedMappingCount) then begin
            SeedLegalMeasures('LEGAL', MeasureCount);
            UpsertDefaultInitiative('LEGAL', InitiativeCount);
        end;
        if UpsertWorkplan('COMPLAINTS', 'Complaints and Compliance Management', 'COMPLAINTS', WorkplanCount, SkippedMappingCount) then begin
            SeedComplaintsMeasures('COMPLAINTS', MeasureCount);
            UpsertDefaultInitiative('COMPLAINTS', InitiativeCount);
        end;
        if UpsertWorkplan('BOARD', 'Board Management Services', 'BOARD', WorkplanCount, SkippedMappingCount) then begin
            SeedBoardMeasures('BOARD', MeasureCount);
            UpsertDefaultInitiative('BOARD', InitiativeCount);
        end;
        if UpsertWorkplan('KJA', 'Judicial Education, Training and Curriculum Development', 'KJA', WorkplanCount, SkippedMappingCount) then begin
            SeedJudicialEducationMeasures('KJA', MeasureCount);
            UpsertDefaultInitiative('KJA', InitiativeCount);
        end;
        if UpsertWorkplan('ICT', 'Information Communication and Technology', 'ICT', WorkplanCount, SkippedMappingCount) then begin
            SeedICTMeasures('ICT', MeasureCount);
            UpsertDefaultInitiative('ICT', InitiativeCount);
        end;
        if UpsertWorkplan('DICT', 'Directorate of Information Communication and Technology', 'DICT', WorkplanCount, SkippedMappingCount) then begin
            SeedICTMeasures('DICT', MeasureCount);
            UpsertDefaultInitiative('DICT', InitiativeCount);
        end;
        if UpsertWorkplan('COMM', 'Corporate Communications', 'COMM', WorkplanCount, SkippedMappingCount) then begin
            SeedCommunicationMeasures('COMM', MeasureCount);
            UpsertDefaultInitiative('COMM', InitiativeCount);
        end;
        if UpsertWorkplan('SCM', 'Supply Chain Management', 'SCM', WorkplanCount, SkippedMappingCount) then begin
            SeedSupplyChainMeasures('SCM', MeasureCount);
            UpsertDefaultInitiative('SCM', InitiativeCount);
        end;
        if UpsertWorkplan('ADMIN', 'Administration', 'ADMIN', WorkplanCount, SkippedMappingCount) then begin
            SeedAdministrationMeasures('ADMIN', MeasureCount);
            UpsertDefaultInitiative('ADMIN', InitiativeCount);
        end;
        if UpsertWorkplan('M&E', 'Monitoring and Evaluation', 'M&E', WorkplanCount, SkippedMappingCount) then begin
            SeedMonitoringEvaluationMeasures('M&E', MeasureCount);
            UpsertDefaultInitiative('M&E', InitiativeCount);
        end;
        if UpsertWorkplan('AUDIT', 'Internal Audit', 'AUDIT', WorkplanCount, SkippedMappingCount) then begin
            SeedInternalAuditMeasures('AUDIT', MeasureCount);
            UpsertDefaultInitiative('AUDIT', InitiativeCount);
        end;
        if UpsertWorkplan('RECORDS', 'Records Management', 'RECORDS', WorkplanCount, SkippedMappingCount) then begin
            SeedRecordsMeasures('RECORDS', MeasureCount);
            UpsertDefaultInitiative('RECORDS', InitiativeCount);
        end;
        if UpsertWorkplan('REGISTRAR', 'Office Administration', 'REGISTRAR', WorkplanCount, SkippedMappingCount) then begin
            SeedOfficeAdministrationMeasures('REGISTRAR', MeasureCount);
            UpsertDefaultInitiative('REGISTRAR', InitiativeCount);
        end;
        if UpsertWorkplan('RNP', 'Research and Policy', 'RNP', WorkplanCount, SkippedMappingCount) then begin
            SeedResearchPolicyMeasures('RNP', MeasureCount);
            UpsertDefaultInitiative('RNP', InitiativeCount);
        end;
    end;

    local procedure SeedHumanResourceMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage of approved vacancies filled within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness of recruitment and selection processes.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage implementation of the annual recruitment plan.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Accuracy and timeliness of staff establishment and workforce planning reports.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Percentage completion of staff induction and onboarding programmes.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Percentage implementation of the annual training and capacity-building plan.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Percentage of staff trained against identified training needs.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Timely preparation and implementation of succession planning initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Percentage compliance with performance management processes and timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Employee productivity and performance improvement initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Timeliness in processing promotions, redesignations, and appointments.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Timeliness in processing confirmations, transfers, and deployments.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Accuracy and timeliness of payroll and personnel records management.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Percentage of staff records updated and maintained in the Human Resource Information System (HRIS).', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Timeliness in processing employee benefits, leave, pensions, and other entitlements.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Percentage compliance with labour laws, HR policies, and public service regulations.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Number of HR policies, guidelines, and procedures reviewed and implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Timeliness in handling disciplinary and grievance matters.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Percentage of disciplinary cases concluded within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Number of employee wellness and staff engagement programmes conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Employee satisfaction and engagement index.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Staff retention rate.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Employee turnover rate within acceptable levels.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Timeliness in responding to HR-related inquiries and requests.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Number of occupational health, safety, and wellness initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Percentage implementation of diversity, inclusion, and gender mainstreaming initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Timeliness and quality of HR reports submitted to management and the Commission.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Number of HR audits conducted and audit recommendations implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Number of staff recognition and reward initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Effective management of internship, attachment, and graduate trainee programmes.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Number of organizational development and change management initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Contribution to institutional capacity building and talent management.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Demonstration of professionalism, integrity, teamwork, innovation, and customer service in HR service delivery.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Timely development, review and implementation of HRM&D master plans, policies, procedures, guidelines and standards.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Development, review and implementation of policy frameworks on terms and conditions of service, remuneration, HRM&D, wellness, mental health and succession planning.', MeasureCount);
        AddMeasure(WorkplanCode, 36, 'Implementation of staff establishment reviews, workforce planning, succession management and talent management initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 37, 'Timely processing and reporting of disciplinary and grievance cases referred to the Commission.', MeasureCount);
        AddMeasure(WorkplanCode, 38, 'Implementation of performance contracting, annual work plans, performance management and appraisal frameworks.', MeasureCount);
        AddMeasure(WorkplanCode, 39, 'Accuracy, completeness, confidentiality and accessibility of HRM&D information systems, records and knowledge management systems.', MeasureCount);
        AddMeasure(WorkplanCode, 40, 'Implementation of service delivery standards, staff welfare, wellness, health and safety initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 41, 'Quality and timeliness of HR advisory briefs, board papers, reports and policy guidance submitted to the Commission.', MeasureCount);
    end;

    local procedure SeedFinanceMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage absorption of approved budget.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness and accuracy of annual budget preparation and submission.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage implementation of approved budget and work plans.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness of processing payments to suppliers, staff, and service providers.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Accuracy of payment processing and financial transactions.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Percentage reduction in pending bills and outstanding obligations.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Timeliness and accuracy of monthly, quarterly, and annual financial reports.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Compliance with the Public Finance Management Act, regulations, and Treasury guidelines.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Number of audit queries raised and resolved within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Percentage implementation of internal and external audit recommendations.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Timeliness of bank reconciliations and ledger reconciliations.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Accuracy and completeness of accounting records maintained.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Timeliness in preparation and submission of statutory deductions and returns.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Percentage compliance with financial reporting standards and accounting policies.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Effective cash flow forecasting and management.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Percentage variance between approved budget and actual expenditure maintained within acceptable limits.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Timeliness and accuracy of financial statements preparation.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Number of financial risks identified and mitigation measures implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Compliance with procurement and expenditure control procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Percentage of financial transactions supported by complete and accurate documentation.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Timeliness in responding to audit, management, and stakeholder queries.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Number of financial management training and sensitization programmes conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Timeliness in preparation of management accounts and financial performance reports.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Percentage implementation of departmental annual work plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Effective management and safeguarding of institutional assets and financial resources.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Timeliness in processing imprests, advances, and surrender of imprests.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Compliance with asset management and inventory control requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Contribution to cost-saving and financial efficiency initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Number of financial process improvement initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Maintenance of sound internal controls and accountability mechanisms.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Stakeholder satisfaction with finance and accounting services.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Development, implementation and monitoring of financial policies, procedures and controls in compliance with applicable law and policy.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Quality and alignment of strategic plans, annual work plans and performance targets with institutional priorities.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Mobilization, oversight and reporting on donor and partner-funded projects.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Implementation of financial controls, operational risk mitigation and accountability measures.', MeasureCount);
        AddMeasure(WorkplanCode, 36, 'Quality and timeliness of reports to internal and external stakeholders.', MeasureCount);
    end;

    local procedure SeedLegalMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Success rate in litigation, appeals, and dispute resolution matters.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Number of court cases effectively monitored and managed.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Timeliness in preparing pleadings, affidavits, submissions, and legal briefs.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Number of legal risks identified and mitigation measures recommended.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Timeliness in responding to legal correspondence and requests.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Number of legislative, policy, and regulatory reviews undertaken.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Quality and timeliness of legal research conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Number of legal research papers, briefs, and reports prepared.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Timeliness in reviewing and interpreting legislation affecting the Commission and Judiciary.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Number of governance and compliance advisory reports prepared.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Percentage implementation of legal recommendations adopted by management.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Number of stakeholder engagements, consultations, and legal awareness programmes conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Timeliness in preparing reports for the Commission, committees, and management.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Compliance with court orders, statutory obligations, and regulatory requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Number of alternative dispute resolution (ADR) matters successfully resolved.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Effectiveness in managing external counsel and legal service providers.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Timeliness in updating legal registers, case records, and documentation.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Number of policy and procedural improvements initiated through legal interventions.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Percentage implementation of departmental annual work plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Contribution to institutional governance, accountability, and risk management.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Maintenance of confidentiality, professional ethics, and legal integrity.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Stakeholder satisfaction with legal services provided.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Demonstration of professionalism, teamwork, innovation, and customer service in legal service delivery.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Effective support to the Commission in appointments, discipline, policy formulation, and statutory mandate execution.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Development, review and implementation of guidelines and policies on representation of the Commission and Judiciary in legal matters.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Negotiation and facilitation of payment of legal fees, costs and awards in accordance with approved procedures.', MeasureCount);
    end;

    local procedure SeedComplaintsMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Number of complaints investigated and concluded.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Percentage implementation of recommendations arising from investigations and complaints reviews.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Number of compliance breaches identified and addressed.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Number of compliance advisory opinions and guidance notes issued.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Number of emerging compliance issues identified and escalated for management action.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Contribution to institutional governance, transparency, and accountability initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Development, implementation and review of complaints prevention strategies.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Development and implementation of regulations on raising and handling petitions against judges and complaints against judicial officers and staff.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Accuracy, completeness and currency of petitions and complaints registers, databases and complaints management information systems.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Quality of legal and procedural support provided to Commission panels and Committees during oral hearings.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Identification, analysis and escalation of emerging gaps in law, policy or procedure for policy intervention.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Development, issuance and review of policies and guidelines on access to information, transparency, accountability, ethics, governance, national values and public service principles.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Implementation of sensitization programmes on code of conduct, ethics, values, principles and declarations of income, assets and liabilities.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Timeliness, accuracy and completeness of DIAL administration, processing, reporting and communication of Commission decisions.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Development, implementation and review of investigation frameworks, methodologies and operating procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Timely identification of complaints requiring investigation and constitution of investigation teams with clear terms of reference.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Effectiveness of intelligence gathering, risk escalation and liaison with other investigative agencies.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Quality of recommendations arising from investigations and their usefulness in Commission decision-making.', MeasureCount);
    end;

    local procedure SeedBoardMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage implementation of the Board/Commission annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness in planning, coordinating, and facilitating Commission meetings.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage of Commission meetings convened as scheduled.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness in preparation and circulation of meeting notices, agendas, and board papers.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Percentage of board papers circulated within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Quality, accuracy, and completeness of board papers submitted for consideration.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Timeliness in preparation and confirmation of Committee and Commission minutes.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Percentage of minutes prepared and circulated within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Timeliness in communicating Commission decisions and resolutions to relevant stakeholders.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Percentage of Commission resolutions communicated within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Effectiveness in tracking implementation of Commission resolutions.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Percentage implementation of Commission resolutions and directives.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Timeliness in preparation and submission of Committee and Commission reports.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Quality and accuracy of Commission records and documentation.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Compliance with statutory, governance, and procedural requirements relating to Commission operations.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Effective management and maintenance of Commission records, registers, and archives.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Timeliness in coordinating Commission interviews, hearings, and special sessions.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Percentage of Commission activities supported without logistical disruptions.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Effectiveness in coordinating induction and orientation programmes for Commissioners Members.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Timeliness in facilitating Commission travel, retreats, and official engagements.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Compliance with governance frameworks, policies, and best practices.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Number of governance advisory notes and guidance reports prepared.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Timeliness in responding to requests from Commissioners and Commission Committees.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Effectiveness in coordinating Commission committee activities.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Percentage of committee meetings supported and documented within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Timeliness in preparing and updating Commission calendars and schedules.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Number of governance and board management process improvements implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Stakeholder satisfaction with Commission secretariat services.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Timeliness and quality of reports submitted to the Commission and Committees.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Percentage implementation of audit recommendations relating to governance and board management.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Effective coordination of stakeholder engagement relating to Commission functions.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Compliance with confidentiality, information security, and records management requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Timeliness in preparation of statutory and governance compliance reports.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Demonstration of professionalism, integrity, accountability, teamwork, and customer service in board management services.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Contribution to effective governance, decision-making, accountability, and achievement of institutional objectives.', MeasureCount);
    end;

    local procedure SeedJudicialEducationMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Timely completion and application of training needs assessments to inform programme planning and prioritization.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Quality, relevance and currency of judicial education curricula, training manuals, materials and tools.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Integration of jurisprudential developments, research findings and best practices into curriculum content.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Effectiveness of trainer, facilitator and consultant identification, accreditation, engagement and evaluation processes.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Implementation of face-to-face, blended and e-learning platforms to enhance accessibility and efficiency.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Monitoring, evaluation and impact assessment of training programmes and capacity-building interventions.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Compliance with academic standards, institutional frameworks and approved training policies.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Timely reporting on programme outcomes, curriculum innovations and training performance indicators.', MeasureCount);
    end;

    local procedure SeedICTMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage system availability (uptime) for critical ICT systems and applications.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness in resolving ICT incidents and service requests.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage of ICT incidents resolved within agreed service level timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Number of system outages and downtime incidents recorded.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Timeliness in responding to user support requests.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'User satisfaction with ICT services and support.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Percentage implementation of the ICT annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Timeliness in implementation of ICT projects and initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Percentage completion of approved ICT projects within budget and timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Number of business processes automated or digitized.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Availability and reliability of Commission ICT infrastructure.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Percentage compliance with ICT policies, standards, and procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Number of cybersecurity assessments conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Percentage implementation of cybersecurity recommendations.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Number of cybersecurity incidents detected, managed, and resolved.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Compliance with information security, data protection, and privacy requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Frequency and success rate of data backup and recovery processes.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Timeliness in conducting system maintenance and upgrades.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Number of preventive maintenance activities undertaken.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Percentage of ICT equipment and assets inventoried and accounted for.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Timeliness in procurement planning and deployment of ICT equipment and solutions.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Number of ICT innovations and digital transformation initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Quality and timeliness of ICT advisory services provided to management and users.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Number of ICT training and user sensitization programmes conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Percentage of staff trained on ICT systems and cybersecurity awareness.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Timeliness and accuracy of ICT performance and management reports.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Number of ICT audits conducted and audit recommendations implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Compliance with software licensing and asset management requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Effectiveness of network performance, connectivity, and communication systems.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Percentage availability of email, internet, and collaboration platforms.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Timeliness in supporting virtual meetings, interviews, and Commission activities.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Number of system enhancements and improvements implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Compliance with business continuity and disaster recovery requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Number of emerging technologies evaluated and adopted to improve service delivery.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Stakeholder satisfaction with ICT systems and services.', MeasureCount);
        AddMeasure(WorkplanCode, 36, 'Demonstration of innovation, professionalism, teamwork, integrity, and customer service in ICT service delivery.', MeasureCount);
        AddMeasure(WorkplanCode, 37, 'Contribution to institutional efficiency, digital transformation, and achievement of strategic objectives.', MeasureCount);
    end;

    local procedure SeedCommunicationMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Timeliness in developing and implementing the Corporate Communications annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Percentage implementation of communication and stakeholder engagement activities.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Timeliness in preparing and disseminating press releases, statements, and media responses.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Number of media engagements, press briefings, and public communication initiatives conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Accuracy, quality, and consistency of information disseminated to stakeholders.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Percentage of media inquiries responded to within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Number of positive media mentions and publications on the Commission and Judiciary initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Effectiveness of media monitoring, analysis, and reporting.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Timeliness in preparing media monitoring and communication reports.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Number of public awareness and civic education programmes conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Reach and impact of public awareness campaigns.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Growth in website traffic, digital engagement, and online visibility.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Timeliness in updating the Commission''s website and digital communication platforms.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Number of communication materials developed, published, and disseminated.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Quality and effectiveness of publications, newsletters, reports, and promotional materials.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Number of stakeholder engagement forums, meetings, and outreach activities coordinated.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Stakeholder satisfaction with communication and information-sharing initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Effectiveness in managing institutional reputation and public image.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Timeliness and effectiveness in managing communication during crises and emerging issues.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Number of communication strategies, policies, and guidelines developed or reviewed.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Percentage implementation of branding and corporate identity standards.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Number of social media campaigns and engagement initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Growth in social media audience, reach, and engagement levels.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Timeliness in responding to public inquiries through communication channels.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Number of internal communication initiatives undertaken to enhance staff engagement.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Effectiveness of internal communication and information dissemination mechanisms.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Compliance with communication policies, protocols, and legal requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Timeliness and quality of communication support provided during Commission meetings, interviews, and official events.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Number of strategic partnerships and collaborations established to enhance public communication.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Percentage implementation of departmental annual work plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Number of innovations introduced to improve communication and stakeholder engagement.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Timeliness and quality of departmental reports submitted to management and the Commission.', MeasureCount);
    end;

    local procedure SeedSupplyChainMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage implementation of the Annual Procurement Plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness in preparation and submission of procurement plans.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage of procurement activities completed within approved timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Compliance with the provisions of the Public Procurement and Asset Disposal Act (PPADA) and related regulations.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Percentage of procurement processes conducted in accordance with approved procurement methods.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Timeliness in processing procurement requests and requisitions.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Average procurement cycle time from requisition to contract award.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Percentage of procurement requests processed within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Timeliness in preparation and execution of procurement contracts.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Percentage of contracts executed and completed within agreed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Number of procurement-related audit queries raised and resolved.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Percentage implementation of procurement audit recommendations.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Compliance with procurement records management requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Accuracy and completeness of procurement documentation maintained.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Timeliness in preparation and submission of procurement and asset management reports.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Percentage of supplier payments processed within prescribed timelines in collaboration with Finance.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Effectiveness in supplier relationship and performance management.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Percentage of supplier performance evaluations conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Number of supplier complaints and disputes resolved within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Compliance with inventory and stores management procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Accuracy of inventory records and stock reconciliation reports.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Frequency and accuracy of stock-taking exercises conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Percentage reduction in stock variances, losses, and obsolete inventory.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Timeliness in issuance and replenishment of stores and supplies.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Effective management and utilization of institutional assets.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Percentage of assets properly tagged, recorded, and accounted for.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Timeliness in conducting asset verification and asset register updates.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Percentage compliance with asset disposal procedures and regulations.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Number of procurement and asset management process improvements implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Achievement of cost savings and value-for-money initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Percentage utilization of e-procurement and digital procurement systems.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Number of procurement training and sensitization programmes conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Timeliness in providing procurement advisory services to user departments.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Percentage implementation of departmental annual work plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Stakeholder satisfaction with procurement and supply chain services.', MeasureCount);
        AddMeasure(WorkplanCode, 36, 'Compliance with ethical standards, integrity requirements, and conflict-of-interest provisions.', MeasureCount);
        AddMeasure(WorkplanCode, 37, 'Demonstration of professionalism, teamwork, innovation, accountability, and customer service in supply chain management.', MeasureCount);
        AddMeasure(WorkplanCode, 38, 'Contribution to institutional efficiency, transparency, accountability, and prudent management of public resources.', MeasureCount);
    end;

    local procedure SeedAdministrationMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage implementation of the Administration Department annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness in provision of administrative support services to the Commission and Secretariat.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Effectiveness in coordinating Commission meetings, interviews, retreats, and official events.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness in preparation and distribution of meeting logistics and materials.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Effective management and maintenance of office facilities and infrastructure.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Percentage of facilities maintained in accordance with established standards.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Number of preventive maintenance activities undertaken for Commission facilities and equipment.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Effective management and utilization of office space and resources.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Timeliness in provision and distribution of office equipment, furniture, and supplies.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Compliance with occupational health, safety, and workplace standards.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Number of workplace safety inspections conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Effective management and coordination of transport and fleet services.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Percentage availability of official vehicles for authorized assignments.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Timeliness in vehicle servicing, maintenance, and repairs.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Effective fuel management and monitoring.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Percentage reduction in vehicle downtime and operational disruptions.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Timeliness in management of travel arrangements and official duty logistics.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Effective management of office support staff and outsourced service providers.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Number of administrative process improvement initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Stakeholder satisfaction with administrative support services.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Effective coordination of security, cleaning, and maintenance services.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Number of service-level agreements monitored and evaluated.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Cost-effectiveness in utilization of administrative resources and services.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Timeliness, quality and responsiveness of general office services, facilities support and cross-functional administrative services.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Availability, reliability and cost-effective management of transport, outsourced services, office equipment and work environment support.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Compliance with occupational health, safety, workplace, administrative and service delivery standards.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Quality, confidentiality and accessibility of administrative records and information management systems.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Implementation of staff welfare, workplace support, disability and inclusion-related administrative initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Effectiveness of internal client service, issue resolution and administrative advisory support.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Prudent utilization, control and safeguarding of administrative resources and assets.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Timely preparation and submission of administrative reports, plans and performance updates.', MeasureCount);
    end;

    local procedure SeedMonitoringEvaluationMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage implementation of the Monitoring and Evaluation annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness in preparation and submission of M&E reports.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage of quarterly, mid-year, and annual performance reports submitted within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness in developing and reviewing institutional performance frameworks and indicators.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Percentage of directorates and departments supported in performance planning and target setting.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Quality and accuracy of performance data collected, analyzed, and reported.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Percentage compliance with institutional performance management requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Timeliness in monitoring implementation of strategic plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Percentage achievement of strategic plan performance indicators monitored and reported.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Number of monitoring visits, Directorate/Departmental assessments, and performance reviews conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Timeliness in tracking implementation of annual work plans and departmental targets.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Percentage implementation of recommendations arising from monitoring and evaluation exercises.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Number of evaluation studies conducted and completed.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Quality and relevance of evaluation findings and recommendations.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Timeliness in dissemination of monitoring and evaluation findings to management and stakeholders.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Percentage of performance reports validated and approved within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Number of performance dashboards and monitoring tools developed and maintained.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Effectiveness in coordinating institutional performance review meetings.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Percentage of performance contracts and appraisal processes monitored and supported.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Number of capacity-building programmes conducted on performance management and M&E.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Percentage of staff trained on monitoring, evaluation, and reporting requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Timeliness in responding to requests for performance information and analysis.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Number of research, surveys, and impact assessments undertaken.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Quality and utilization of data for decision-making and policy formulation.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Number of innovations and process improvements introduced in monitoring and evaluation systems.', MeasureCount);
    end;

    local procedure SeedInternalAuditMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage implementation of the Internal Audit annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness in preparation and submission of annual and periodic audit plans.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage of planned audits completed within approved timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness in conducting audit assignments and issuing audit reports.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Number of audit reports completed and submitted within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Quality, accuracy, and completeness of audit reports issued.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Percentage implementation of audit recommendations by management.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Effectiveness in tracking and following up implementation of audit recommendations.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Number of follow-up audits conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Timeliness in reporting significant audit findings and risks to management and the Commission.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Number of risk-based audits conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Effectiveness in identifying and assessing institutional risks and control weaknesses.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Number of internal control reviews undertaken.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Percentage of internal control weaknesses addressed through management action.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Compliance with the International Standards for the Professional Practice of Internal Auditing (IPPF).', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Compliance with Public Finance Management Act, regulations, and applicable governance frameworks.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Number of advisory and consultancy engagements undertaken.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Timeliness in providing audit advisory services to management.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Effectiveness in evaluating governance, risk management, and control processes.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Number of fraud risk assessments and investigations conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Timeliness in reporting suspected fraud, irregularities, and control breaches.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Number of audit queries resolved through management intervention.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Percentage reduction in recurring audit findings.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Number of special audits and investigations completed.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Timeliness in preparation and presentation of audit committee reports.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Quality and relevance of audit committee reports and presentations.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Percentage implementation of quality assurance and improvement programme activities.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Number of audit staff trained and professionally developed.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Compliance with audit documentation and records management requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Timeliness and accuracy of audit working papers and audit files.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Number of process improvement recommendations issued and adopted.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Percentage implementation of departmental annual work plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Stakeholder satisfaction with internal audit services.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Timeliness in responding to management requests for audit reviews and advisory support.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Number of emerging risks identified and communicated to management.', MeasureCount);
        AddMeasure(WorkplanCode, 36, 'Demonstration of independence, objectivity, integrity, professionalism, confidentiality, and ethical conduct.', MeasureCount);
        AddMeasure(WorkplanCode, 37, 'Contribution to institutional accountability, transparency, prudent resource utilization, and achievement of organizational objectives.', MeasureCount);
    end;

    local procedure SeedRecordsMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage implementation of the Records Management annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Timeliness in receiving, registering, classifying, and filing records and correspondence.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Percentage of records captured and maintained in accordance with approved records management procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness in retrieval and provision of records upon request.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Percentage of records retrieved within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Accuracy and completeness of records maintained.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Percentage of records properly indexed, classified, and archived.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Compliance with records management policies, procedures, and standards.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Compliance with the Public Archives and Documentation Service Act, Data Protection Act, and other applicable regulations.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Timeliness in processing incoming and outgoing correspondence.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Percentage of correspondence processed and routed within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Number of records audits and inspections conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Percentage implementation of records audit recommendations.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Timeliness in updating and maintaining records inventories and registers.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Percentage of active and inactive records appropriately managed and accounted for.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Number of records digitized and uploaded into electronic records management systems.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Percentage implementation of records digitization initiatives.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Effectiveness in managing electronic records and document management systems.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Percentage reduction in misplaced, lost, or unaccounted-for records.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Compliance with records retention and disposal schedules.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Number of records disposed of in accordance with approved procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Timeliness in preparation and submission of records management reports.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Number of staff sensitization and training programmes conducted on records management.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Percentage of staff trained on records management policies and procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Effectiveness in safeguarding confidential and sensitive information.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Number of breaches of records security and confidentiality reported (target: zero).', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Timeliness in responding to requests for information and records.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Quality and organization of archives and records storage facilities.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Percentage of records storage facilities maintained in accordance with prescribed standards.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Number of records management process improvement initiatives implemented.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Percentage implementation of departmental annual work plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Stakeholder satisfaction with records management services.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Compliance with information governance, access to information, and data protection requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Timeliness and effectiveness in supporting Commission meetings, interviews, and governance processes through proper records management.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Demonstration of professionalism, integrity, accountability, teamwork, innovation, and customer service in records management service delivery.', MeasureCount);
        AddMeasure(WorkplanCode, 36, 'Contribution to institutional efficiency, accountability, transparency, and preservation of institutional memory.', MeasureCount);
    end;

    local procedure SeedOfficeAdministrationMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Timeliness in receiving, recording, and routing correspondence and official documents.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Percentage of correspondence processed within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Accuracy and completeness of records, files, and office documentation maintained.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness in preparation, typing, formatting, and dispatch of official documents.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Percentage of documents prepared without errors or need for major revisions.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Effective management of office diaries, schedules, and appointments.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Timeliness in organizing meetings, interviews, and official engagements.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Percentage of meetings supported without logistical disruptions.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Timeliness in preparation and circulation of meeting notices, agendas, and supporting documents.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Accuracy and timeliness in preparation of meeting minutes and action points.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Percentage of minutes prepared and circulated within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Effective tracking and follow-up of decisions, resolutions, and action points.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Timeliness in responding to telephone calls, emails, and stakeholder inquiries.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Quality of customer service provided to internal and external stakeholders.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Effective management of office filing systems and records.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Percentage of files and records retrieved within prescribed timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Compliance with records management and information security requirements.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Effective management of office supplies, equipment, and administrative resources.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Timeliness in requisitioning and monitoring office supplies.', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'Maintenance of confidentiality and security of official information and documents.', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Compliance with office procedures, policies, and administrative guidelines.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Timeliness in preparation and submission of administrative and operational reports.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Effective coordination of travel arrangements, accommodation, and logistics for official assignments.', MeasureCount);
        AddMeasure(WorkplanCode, 24, 'Number of administrative support activities successfully coordinated.', MeasureCount);
        AddMeasure(WorkplanCode, 25, 'Accuracy in maintaining contact databases, registers, and office inventories.', MeasureCount);
        AddMeasure(WorkplanCode, 26, 'Timeliness in processing requests and providing administrative support services.', MeasureCount);
        AddMeasure(WorkplanCode, 27, 'Effective coordination of visitors, guests, and stakeholder engagements.', MeasureCount);
        AddMeasure(WorkplanCode, 28, 'Number of process improvement initiatives implemented in office administration.', MeasureCount);
        AddMeasure(WorkplanCode, 29, 'Percentage implementation of individual annual work plan targets.', MeasureCount);
        AddMeasure(WorkplanCode, 30, 'Stakeholder satisfaction with secretarial and office administration services.', MeasureCount);
        AddMeasure(WorkplanCode, 31, 'Effective use of office technology and electronic document management systems.', MeasureCount);
        AddMeasure(WorkplanCode, 32, 'Demonstration of professionalism, integrity, teamwork, reliability, and customer service.', MeasureCount);
        AddMeasure(WorkplanCode, 33, 'Ability to prioritize assignments and meet deadlines.', MeasureCount);
        AddMeasure(WorkplanCode, 34, 'Contribution to efficiency, productivity, and smooth operations of the office.', MeasureCount);
        AddMeasure(WorkplanCode, 35, 'Adherence to institutional values, code of conduct, and performance standards.', MeasureCount);
    end;

    local procedure SeedResearchPolicyMeasures(WorkplanCode: Code[50]; var MeasureCount: Integer)
    begin
        AddMeasure(WorkplanCode, 1, 'Percentage implementation of the Research and Policy annual work plan.', MeasureCount);
        AddMeasure(WorkplanCode, 2, 'Number of policy research studies, surveys, and analytical reports completed within approved timelines.', MeasureCount);
        AddMeasure(WorkplanCode, 3, 'Quality, relevance, and evidence-base of research outputs used to inform Commission decisions.', MeasureCount);
        AddMeasure(WorkplanCode, 4, 'Timeliness in preparing policy briefs, concept notes, advisory papers, and research summaries.', MeasureCount);
        AddMeasure(WorkplanCode, 5, 'Number of policies, guidelines, frameworks, and procedures developed, reviewed, or updated.', MeasureCount);
        AddMeasure(WorkplanCode, 6, 'Percentage of approved policy recommendations adopted or implemented by the Commission, management, or relevant committees.', MeasureCount);
        AddMeasure(WorkplanCode, 7, 'Timeliness in reviewing laws, regulations, strategies, and emerging policy issues affecting the Commission and Judiciary.', MeasureCount);
        AddMeasure(WorkplanCode, 8, 'Number of comparative studies, benchmarking exercises, and best-practice reviews undertaken.', MeasureCount);
        AddMeasure(WorkplanCode, 9, 'Effectiveness in coordinating stakeholder consultations, validation forums, and policy engagement processes.', MeasureCount);
        AddMeasure(WorkplanCode, 10, 'Quality and timeliness of reports, board papers, committee briefs, and policy advisory notes submitted to the Commission.', MeasureCount);
        AddMeasure(WorkplanCode, 11, 'Accuracy, completeness, and currency of research databases, policy registers, and knowledge management repositories.', MeasureCount);
        AddMeasure(WorkplanCode, 12, 'Number of emerging policy gaps, institutional risks, and reform areas identified and escalated for action.', MeasureCount);
        AddMeasure(WorkplanCode, 13, 'Level of utilization of research findings and policy analysis in planning, decision-making, and institutional reform.', MeasureCount);
        AddMeasure(WorkplanCode, 14, 'Compliance of research and policy work with approved methodologies, ethical standards, data protection requirements, and institutional procedures.', MeasureCount);
        AddMeasure(WorkplanCode, 15, 'Number of partnerships, collaborations, and knowledge-sharing initiatives established to support research and policy development.', MeasureCount);
        AddMeasure(WorkplanCode, 16, 'Timeliness in disseminating approved research findings, policy updates, and knowledge products to relevant stakeholders.', MeasureCount);
        AddMeasure(WorkplanCode, 17, 'Number of policy monitoring, review, and evaluation exercises conducted.', MeasureCount);
        AddMeasure(WorkplanCode, 18, 'Contribution to evidence-based decision-making, institutional learning, governance improvement, and realization of the Commission’s mandate.', MeasureCount);
        AddMeasure(WorkplanCode, 19, 'Performance Moderation Committee', MeasureCount);
        AddMeasure(WorkplanCode, 20, 'A Secretariat Performance Moderation Committee shall be established to:', MeasureCount);
        AddMeasure(WorkplanCode, 21, 'Ensure consistency in ratings across departments.', MeasureCount);
        AddMeasure(WorkplanCode, 22, 'Address rating disparities.', MeasureCount);
        AddMeasure(WorkplanCode, 23, 'Promote fairness and objectivity.', MeasureCount);
    end;

    local procedure AddMeasure(WorkplanCode: Code[50]; SequenceNo: Integer; Description: Text; var MeasureCount: Integer)
    var
        Measure: Record "Appraisal Perfomance Measures";
        MeasureCode: Code[50];
        ShortDescription: Text[250];
    begin
        MeasureCode := BuildMeasureCode(WorkplanCode, SequenceNo);
        ShortDescription := CopyStr(Description, 1, MaxStrLen(Measure.Description));

        if Measure.Get(WorkplanCode, MeasureCode) then begin
            if Measure.Description <> ShortDescription then begin
                Measure.Description := ShortDescription;
                Measure.Modify(true);
            end;
        end else begin
            Measure.Init();
            Measure."Workplan Code" := WorkplanCode;
            Measure.Code := MeasureCode;
            Measure.Description := ShortDescription;
            Measure.Insert(true);
        end;

        MeasureCount += 1;
    end;

    local procedure BuildMeasureCode(WorkplanCode: Code[50]; SequenceNo: Integer): Code[50]
    begin
        exit(CopyStr(StrSubstNo('%1-%2', WorkplanCode, SequenceNo), 1, 50));
    end;

    local procedure UpsertWorkplan(WorkplanCode: Code[50]; Description: Text[100]; ResponsibilityCenterCode: Code[10]; var WorkplanCount: Integer; var SkippedMappingCount: Integer): Boolean
    var
        ResponsibilityCenter: Record "Responsibility Center";
        Workplan: Record "Appraisal Workplan Code";
    begin
        if ResponsibilityCenterCode <> '' then
            if not ResponsibilityCenter.Get(ResponsibilityCenterCode) then begin
                SkippedMappingCount += 1;
                exit(false);
            end;

        if Workplan.Get(WorkplanCode) then begin
            if (Workplan.Description <> Description) or (Workplan."Responsibility Center" <> ResponsibilityCenterCode) then begin
                Workplan.Description := Description;
                Workplan."Responsibility Center" := ResponsibilityCenterCode;
                Workplan.Modify(true);
            end;
        end else begin
            Workplan.Init();
            Workplan.Code := WorkplanCode;
            Workplan.Description := Description;
            Workplan."Responsibility Center" := ResponsibilityCenterCode;
            Workplan.Insert(true);
        end;

        WorkplanCount += 1;
        exit(true);
    end;

    local procedure UpsertDefaultInitiative(WorkplanCode: Code[50]; var InitiativeCount: Integer)
    var
        Initiative: Record "Strategic Imp Initiatives";
        InitiativeCode: Code[20];
        InitiativeText: Text[150];
        ObjectiveCode: Code[10];
    begin
        InitiativeCode := 'GEN';
        InitiativeText := 'Deliver agreed KPI outputs and maintain verifiable evidence.';
        ObjectiveCode := CopyStr(WorkplanCode, 1, MaxStrLen(ObjectiveCode));

        if Initiative.Get(ObjectiveCode, InitiativeCode) then begin
            if Initiative.Initiatives <> InitiativeText then begin
                Initiative.Initiatives := InitiativeText;
                Initiative."Strategic Objectives" := 'Seeded from JSC Secretariat Performance Review Framework, June 2026.';
                Initiative.Modify(true);
            end;
        end else begin
            Initiative.Init();
            Initiative.ObjectiveCode := ObjectiveCode;
            Initiative.Code := InitiativeCode;
            Initiative.Initiatives := InitiativeText;
            Initiative."Strategic Objectives" := 'Seeded from JSC Secretariat Performance Review Framework, June 2026.';
            Initiative.Insert(true);
        end;

        InitiativeCount += 1;
    end;

    local procedure SeedRatingScale(var RatingCount: Integer)
    begin
        UpsertRatingScale(0, 'Unsatisfactory', RatingCount);
        UpsertRatingScale(60, 'Fair', RatingCount);
        UpsertRatingScale(70, 'Good', RatingCount);
        UpsertRatingScale(80, 'Very Good', RatingCount);
        UpsertRatingScale(90, 'Outstanding', RatingCount);
    end;

    local procedure UpsertRatingScale(Score: Decimal; Description: Text[50]; var RatingCount: Integer)
    var
        RatingScale: Record "Bal Score Card Rating";
    begin
        if RatingScale.Get(Score) then begin
            if RatingScale.Name <> Description then begin
                RatingScale.Name := Description;
                RatingScale.Modify(true);
            end;
        end else begin
            RatingScale.Init();
            RatingScale.Score := Score;
            RatingScale.Name := Description;
            RatingScale.Insert(true);
        end;

        RatingCount += 1;
    end;

    local procedure SeedGradeMatrix(var MatrixCount: Integer)
    begin
        UpsertGradeMatrix('UNSAT', 0, 59.99, 'Unsatisfactory', MatrixCount);
        UpsertGradeMatrix('FAIR', 60, 69.99, 'Fair', MatrixCount);
        UpsertGradeMatrix('GOOD', 70, 79.99, 'Good', MatrixCount);
        UpsertGradeMatrix('VERYGOOD', 80, 89.99, 'Very Good', MatrixCount);
        UpsertGradeMatrix('OUTSTANDING', 90, 100, 'Outstanding', MatrixCount);
    end;

    local procedure UpsertGradeMatrix(Code: Code[1500]; StartScore: Decimal; EndScore: Decimal; Grade: Text[20]; var MatrixCount: Integer)
    var
        Matrix: Record "Perfomance rating matrix";
    begin
        if Matrix.Get(Code) then begin
            if (Matrix.Start <> StartScore) or (Matrix."End" <> EndScore) or (Matrix.Grade <> Grade) then begin
                Matrix.Start := StartScore;
                Matrix."End" := EndScore;
                Matrix.Grade := Grade;
                Matrix.Modify(true);
            end;
        end else begin
            Matrix.Init();
            Matrix.Code := Code;
            Matrix.Start := StartScore;
            Matrix."End" := EndScore;
            Matrix.Grade := Grade;
            Matrix.Insert(true);
        end;

        MatrixCount += 1;
    end;

    local procedure SeedCompetencies(var AttributeCount: Integer; var IndicatorCount: Integer)
    begin
        UpsertCompetency('INTEGRITY', 'Integrity and Ethical Conduct', 'INTEGRITY-01', 'Demonstrates integrity, ethical conduct, impartiality, and compliance with institutional values.', AttributeCount, IndicatorCount);
        UpsertCompetency('TEAMWORK', 'Teamwork and Collaboration', 'TEAMWORK-01', 'Works collaboratively with colleagues, directorates, and stakeholders to deliver agreed results.', AttributeCount, IndicatorCount);
        UpsertCompetency('COMM-SKILL', 'Communication Skills', 'COMM-SKILL-01', 'Communicates clearly, professionally, and in a timely manner in written and oral engagements.', AttributeCount, IndicatorCount);
        UpsertCompetency('CUSTOMER', 'Customer Service Orientation', 'CUSTOMER-01', 'Responds to internal and external customers with courtesy, accountability, and service focus.', AttributeCount, IndicatorCount);
        UpsertCompetency('PROBLEM', 'Problem Solving and Initiative', 'PROBLEM-01', 'Identifies issues, proposes practical solutions, and takes initiative to improve service delivery.', AttributeCount, IndicatorCount);
        UpsertCompetency('LEARNING', 'Professional Development and Learning', 'LEARNING-01', 'Pursues learning, applies acquired skills, and supports continuous professional development.', AttributeCount, IndicatorCount);
    end;

    local procedure UpsertCompetency(AttributeCode: Code[20]; AttributeDescription: Text[2048]; IndicatorCode: Code[50]; IndicatorDescription: Text[2048]; var AttributeCount: Integer; var IndicatorCount: Integer)
    var
        Attribute: Record "Work related attributes";
        Indicator: Record "Work related indicators";
    begin
        if Attribute.Get(AttributeCode) then begin
            if Attribute.Description <> AttributeDescription then begin
                Attribute.Description := AttributeDescription;
                Attribute.Modify(true);
            end;
        end else begin
            Attribute.Init();
            Attribute.Code := AttributeCode;
            Attribute.Description := AttributeDescription;
            Attribute.Insert(true);
        end;
        AttributeCount += 1;

        if Indicator.Get(AttributeCode, IndicatorCode) then begin
            if Indicator.Description <> IndicatorDescription then begin
                Indicator.Description := IndicatorDescription;
                Indicator.Modify(true);
            end;
        end else begin
            Indicator.Init();
            Indicator.AttributeCode := AttributeCode;
            Indicator.Code := IndicatorCode;
            Indicator.Description := IndicatorDescription;
            Indicator.Insert(true);
        end;
        IndicatorCount += 1;
    end;
}
