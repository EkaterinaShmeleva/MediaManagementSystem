use mmsDB;

DROP VIEW IF EXISTS master_view;
CREATE VIEW IF NOT EXISTS master_view AS
SELECT mt.mediaID, mt.title, mt.media_type, w.withdrawnAt, w.withdrawnBy, l.label, l.category, m2l.fpath
FROM media_titles AS mt
LEFT JOIN med_at_loc AS m2l ON mt.mediaID = m2l.mediaID
LEFT JOIN locations AS l ON m2l.locationID = l.locationID
LEFT JOIN withdrawals AS w ON mt.mediaID = w.mediaID
;
