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
        Status_Reason = rp.Status_Reason
    FROM DW.dbo.DimEmail dwh
    JOIN DEP2.dbo.CDI_Mailing rm on dwh.Mailing_ID = rm.Mailing_ID
    JOIN DEP2.dbo.CDI_PageView rp on dwh.Campagne_ID = rp.Campagne_ID
    WHERE rm.Mailing_ID IS NOT NULL;

    INSERT INTO DW.dbo.DimEmail
    (Mailing_ID, Mailing_Name, Mailing_Sent_On, Mailing_Subject, Browser, Campagne_ID, Contact_ID, Duration, Operating_System, Referrer_Type,
    PageView_Time, Title, Type, Viewed_On, Visit, Visitor_key, Web_Content, Made_On, Edited_By, Edited_On, Status, Status_Reason)
    SELECT DISTINCT rm.Mailing_ID, rm.Mailing_Name, rm.Mailing_Sent_On, rm.Mailing_Subject, rp.Browser, rp.Campagne_ID, rp.Contact_ID, rp.Duration, rp.Operating_System, rp.Referrer_Type,
    rp.PageView_Time, rp.Title, rp.Type, rp.Viewed_On, rp.Visit, rp.Visitor_key, rp.Web_Content, rp.Made_On, rp.Edited_By, rp.Edited_On, rp.Status, rp.Status_Reason
    FROM DEP2.dbo.CDI_Mailing rm
    JOIN DEP2.dbo.CDI_Visits rv ON rm.Mailing_ID = rv.Email_Send
    JOIN DEP2.dbo.CDI_PageView rp ON rv.Visit_ID = rp.Visit
    WHERE rm.Mailing_ID IS NOT NULL;

END;