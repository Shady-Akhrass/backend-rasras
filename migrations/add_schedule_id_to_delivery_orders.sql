-- Add ScheduleID to deliveryorders table to track specific schedules from Customer Requests
ALTER TABLE deliveryorders ADD COLUMN ScheduleID INT NULL AFTER IssueNoteID;
