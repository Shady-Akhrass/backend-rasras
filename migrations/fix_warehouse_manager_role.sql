-- Fix Warehouse Manager Approval Steps
-- Corrects the ApproverRoleID to point to 'WHM' instead of the incorrect fallback

-- Get the correct WHM and SM role IDs
SET @whm_role_id = (SELECT RoleID FROM roles WHERE RoleCode = 'WHM' LIMIT 1);
SET @sm_role_id = (SELECT RoleID FROM roles WHERE RoleCode = 'SM' LIMIT 1);

-- Fallback to IDs from the current database state if codes don't match exactly 
SET @whm_role_id = IFNULL(@whm_role_id, 9);
SET @sm_role_id = IFNULL(@sm_role_id, 7);

-- Get workflow IDs
SET @delivery_workflow_id = (SELECT WorkflowID FROM approvalworkflows WHERE WorkflowCode = 'DELIVERY_APPROVAL');
SET @issue_note_workflow_id = (SELECT WorkflowID FROM approvalworkflows WHERE WorkflowCode = 'ISSUE_NOTE_APPROVAL');

-- Update Step 1 (Warehouse Manager Approval) for Delivery Order
UPDATE approvalworkflowsteps 
SET ApproverRoleID = @whm_role_id, StepName = 'Warehouse Manager Approval'
WHERE WorkflowID = @delivery_workflow_id AND StepNumber = 1;

-- Update Step 2 (Sales Manager Approval) for Delivery Order
UPDATE approvalworkflowsteps 
SET ApproverRoleID = @sm_role_id, StepName = 'Sales Manager Approval'
WHERE WorkflowID = @delivery_workflow_id AND StepNumber = 2;

-- Update Step 1 (Warehouse Manager Approval) for Stock Issue Note
UPDATE approvalworkflowsteps 
SET ApproverRoleID = @whm_role_id, StepName = 'Warehouse Manager Approval'
WHERE WorkflowID = @issue_note_workflow_id AND StepNumber = 1;

-- Update Step 2 (Sales Manager Approval) for Stock Issue Note
UPDATE approvalworkflowsteps 
SET ApproverRoleID = @sm_role_id, StepName = 'Sales Manager Approval'
WHERE WorkflowID = @issue_note_workflow_id AND StepNumber = 2;
