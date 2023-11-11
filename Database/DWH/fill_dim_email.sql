USE DW;
DROP PROCEDURE IF EXISTS fill_dim_email;
GO
CREATE PROCEDURE fill_dim_email
AS
BEGIN
    UPDATE DW.dbo.DimEmail
     SET 
        Mailing_ID = rm.Mailing_ID,
        Mailing_Name = rm.Mailing_Name,
        Mailing_Sent_On = rm.Mailing_Sent_On,
        Mailing_Subject = rm.Mailing_Subject,
        Browser = rp.Browser,
        Campagne_ID = rp.Campagne_ID,
        Contact_ID = rp.Contact_ID,
        Duration = rp.Duration,
        Operating_System = rp.Operating_System,
        Referrer_Type = rp.Referrer_Type,
        PageView_Time = rp.PageView_Time,
        Title = rp.Title,
        Type = rp.Type,
        Viewed_On = rp.Viewed_On,
        Visit = rp.Visit,
        Visitor_key = rp.Visitor_key,
        Web_Content = rp.Web_Content,
        Made_On = rp.Made_On,
        Edited_By = rp.Edited_By,
        Edited_On = rp.Edited_On,
        Status = rp.Status,
        Status_Reason = rp.Status_Reason,
        IP_Stad = rv.IP_Stad,
        IP_Company = rv.IP_Company,
        IP_Land = rv.IP_Land,
        IP_Adress = rv.IP_Adress,
        IP_Organization = rv.IP_Organization,
        Visit_ID = rv.Visit_ID
    FROM DW.dbo.DimEmail dwh
    LEFT JOIN DEP2.dbo.CDI_Mailing rm ON dwh.Mailing_ID = rm.Mailing_ID
    LEFT JOIN DEP2.dbo.CDI_PageView rp ON dwh.Campagne_ID = rp.Campagne_ID
    LEFT JOIN DEP2.dbo.CDI_Visits rv ON dwh.Visit_ID = rv.Visit_ID
    WHERE rm.Mailing_ID IS NOT NULL;

    INSERT INTO DW.dbo.DimEmail
    (Mailing_ID, Mailing_Name, Mailing_Sent_On, Mailing_Subject, Browser, Campagne_ID, Contact_ID, Duration, Operating_System, Referrer_Type,
    PageView_Time, Title, Type, Viewed_On, Visit, Visitor_key, Web_Content, Made_On, Edited_By, Edited_On, Status, Status_Reason,
    IP_Stad, IP_Company, IP_Land, IP_Adress, IP_Organization, Visit_ID)
    SELECT DISTINCT rm.Mailing_ID, rm.Mailing_Name, rm.Mailing_Sent_On, rm.Mailing_Subject, rp.Browser, rp.Campagne_ID, rp.Contact_ID, rp.Duration, rp.Operating_System, rp.Referrer_Type,
    rp.PageView_Time, rp.Title, rp.Type, rp.Viewed_On, rp.Visit, rp.Visitor_key, rp.Web_Content, rp.Made_On, rp.Edited_By, rp.Edited_On, rp.Status, rp.Status_Reason,
    rv.IP_Stad, rv.IP_Company, rv.IP_Land, rv.IP_Adress, rv.IP_Organization, rv.Visit_ID
    FROM DEP2.dbo.CDI_Mailing rm
    JOIN DEP2.dbo.CDI_Visits rv ON rm.Mailing_ID = rv.Email_Send
    JOIN DEP2.dbo.CDI_PageView rp ON rv.Visit_ID = rp.Visit
    WHERE rm.Mailing_ID IS NOT NULL;

END;