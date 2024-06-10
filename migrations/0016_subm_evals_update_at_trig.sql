CREATE OR REPLACE FUNCTION update_updated_at()
  RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER task_subm_evaluations_updated_at_trigger
AFTER UPDATE ON task_subm_evaluations
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();
