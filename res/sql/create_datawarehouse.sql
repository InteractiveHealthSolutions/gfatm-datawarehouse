-- -------------
-- CREATE SCHEMA
-- -------------
CREATE TABLE IF NOT EXISTS _identifier (
  id varchar(255) NOT NULL,
  timestamp datetime NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS _implementation (
  implementation_id int(11) NOT NULL,
  connection_url varchar(255) NOT NULL,
  driver varchar(255) NOT NULL,
  db_name varchar(45) NOT NULL,
  username varchar(45) DEFAULT NULL,
  password varchar(255) DEFAULT NULL COMMENT 'This field is encrypted due to security reasons',
  active bit(1) NOT NULL,
  date_added datetime NOT NULL,
  status varchar(45) DEFAULT NULL,
  last_updated datetime DEFAULT NULL,
  description text,
  PRIMARY KEY (implementation_id),
  UNIQUE KEY implementation_id_UNIQUE (implementation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sensitive! Contains connection information of all data sourc';

CREATE TABLE IF NOT EXISTS common_form_4_29_67 (
  implementation_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  provider varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  location_name varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  patient_id int(11) NOT NULL DEFAULT '0',
  date_entered date DEFAULT NULL,
  tb_infection_type text CHARACTER SET utf8,
  tb_type text CHARACTER SET utf8,
  dst_pattern text CHARACTER SET utf8,
  treatment_enrollment_date text CHARACTER SET utf8,
  district text CHARACTER SET utf8,
  address_type text CHARACTER SET utf8,
  diagnosis_type text CHARACTER SET utf8,
  primary_contact text CHARACTER SET utf8,
  secondary_contact text CHARACTER SET utf8,
  address1 text CHARACTER SET utf8,
  city_village text CHARACTER SET utf8,
  registration_date text CHARACTER SET utf8,
  tb_registration_no text CHARACTER SET utf8,
  PRIMARY KEY (encounter_id),
  KEY encounter_id (encounter_id),
  KEY patient_id (patient_id),
  KEY location_id (location_id),
  KEY date_entered (date_entered)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS commonlab_tmp (
  test_type_id int(11) DEFAULT NULL,
  attribute_type_id int(11) NOT NULL,
  attribute_type_name varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS commonlabtest_attribute (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  test_attribute_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_attribute_test_fk (test_order_id),
  KEY commonlabtest_attribute_attribute_type_fk (attribute_type_id),
  KEY commonlabtest_attribute_creator_fk (creator),
  KEY commonlabtest_attribute_changed_by_fk (changed_by),
  KEY commonlabtest_attribute_voided_by_fk (voided_by),
  KEY commonlabtest_attribute_id_idx (test_attribute_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS commonlabtest_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  test_attribute_type_id int(11) NOT NULL,
  test_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  datatype varchar(255) NOT NULL,
  min_occurs int(11) NOT NULL DEFAULT '0',
  max_occurs int(11) DEFAULT NULL,
  datatype_config text,
  handler_config text,
  sort_weight double DEFAULT NULL,
  description text NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  preferred_handler varchar(255) DEFAULT NULL,
  hint varchar(1024) DEFAULT NULL,
  group_name varchar(255) DEFAULT NULL,
  multiset_name varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_attribute_type_test_type_fk (test_type_id),
  KEY commonlabtest_attribute_type_creator_fk (creator),
  KEY commonlabtest_attribute_type_changed_by_fk (changed_by),
  KEY commonlabtest_attribute_type_retired_by_fk (retired_by),
  KEY commonlabtest_attribute_type_idx (test_attribute_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS commonlabtest_sample (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  test_sample_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  specimen_type int(11) NOT NULL,
  specimen_site int(11) DEFAULT NULL,
  is_expirable tinyint(1) NOT NULL DEFAULT '1',
  expiry_date datetime DEFAULT NULL,
  lab_sample_identifier varchar(50) DEFAULT NULL,
  collector int(11) NOT NULL DEFAULT '0',
  status varchar(50) DEFAULT NULL,
  comments varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  collection_date datetime DEFAULT NULL,
  processed_date datetime DEFAULT NULL,
  quantity double DEFAULT NULL,
  units varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_sample_test_fk (test_order_id),
  KEY commonlabtest_sample_specimen_type_fk (specimen_type),
  KEY commonlabtest_sample_specimen_site_fk (specimen_site),
  KEY commonlabtest_sample_collector_fk (collector),
  KEY commonlabtest_sample_creator_fk (creator),
  KEY commonlabtest_sample_changed_by_fk (changed_by),
  KEY commonlabtest_sample_voided_by_fk (voided_by),
  KEY commonlabtest_sample_idx (test_sample_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS commonlabtest_test (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  test_type_id int(11) NOT NULL,
  lab_reference_number varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  instructions varchar(512) DEFAULT NULL,
  report_file_path varchar(1024) DEFAULT NULL,
  result_comments varchar(1024) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_test_type_fk (test_type_id),
  KEY commonlabtest_test_creator_fk (creator),
  KEY commonlabtest_test_changed_by_fk (changed_by),
  KEY commonlabtest_test_voided_by_fk (voided_by),
  KEY commonlabtest_test_order_idx (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS commonlabtest_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  test_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  short_name varchar(20) DEFAULT NULL,
  test_group varchar(20) NOT NULL,
  requires_specimen tinyint(1) NOT NULL DEFAULT '1',
  reference_concept_id int(11) NOT NULL,
  description text NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_type_creator_fk (creator),
  KEY commonlabtest_type_reference_concept_fk (reference_concept_id),
  KEY commonlabtest_type_changed_by_fk (changed_by),
  KEY commonlabtest_type_retired_by_fk (retired_by),
  KEY commonlabtest_type_idx (test_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS concept (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_id int(11) NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  short_name varchar(255) DEFAULT NULL,
  description text,
  form_text text,
  datatype_id int(11) NOT NULL DEFAULT '0',
  class_id int(11) NOT NULL DEFAULT '0',
  is_set tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  version varchar(50) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid_UNIQUE (uuid),
  KEY concept_uuid_index (uuid),
  KEY concept_classes (class_id),
  KEY concept_creator (creator),
  KEY concept_datatypes (datatype_id),
  KEY user_who_changed_concept (changed_by),
  KEY concept_code (version),
  KEY concept_ndx (version),
  KEY user_who_retired_concept (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_answer (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_answer_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  answer_concept int(11) DEFAULT NULL,
  answer_drug int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  uuid char(38) NOT NULL,
  sort_weight double DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_answer_uuid_index (uuid),
  KEY answer_creator (creator),
  KEY answer (answer_concept),
  KEY answers_for_concept (concept_id),
  KEY answer_answer_drug_fk (answer_drug)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_class (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_class_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_class_uuid_index (uuid),
  KEY concept_class_creator (creator),
  KEY user_who_retired_concept_class (retired_by),
  KEY concept_class_retired_status (retired)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_datatype (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_datatype_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  hl7_abbreviation varchar(3) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_datatype_uuid_index (uuid),
  KEY concept_datatype_creator (creator),
  KEY user_who_retired_concept_datatype (retired_by),
  KEY concept_datatype_retired_status (retired)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_description (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_description_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  description text NOT NULL,
  locale varchar(50) NOT NULL DEFAULT '',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_description_uuid_index (uuid),
  KEY concept_being_described (concept_id),
  KEY user_who_created_description (creator),
  KEY user_who_changed_description (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_latest_name (
  implementation_id int(11) NOT NULL,
  concept_id int(11) NOT NULL,
  default_name bigint(11) DEFAULT NULL,
  short_name bigint(11) DEFAULT NULL,
  full_name bigint(11) DEFAULT NULL,
  PRIMARY KEY (implementation_id,concept_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS concept_map_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_map_type_id int(11) NOT NULL,
  name varchar(255) CHARACTER SET utf8 NOT NULL,
  description varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  is_hidden tinyint(1) DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY name (name),
  KEY uuid (uuid),
  KEY mapped_user_creator_concept_map_type (creator),
  KEY mapped_user_changed_concept_map_type (changed_by),
  KEY mapped_user_retired_concept_map_type (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS concept_name (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_id int(11) DEFAULT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  locale varchar(50) NOT NULL DEFAULT '',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  concept_name_id int(11) NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  concept_name_type varchar(50) DEFAULT NULL,
  locale_preferred tinyint(1) DEFAULT '0',
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_name_id (concept_name_id),
  KEY concept_name_uuid_index (uuid),
  KEY user_who_created_name (creator),
  KEY name_of_concept (name),
  KEY concept_id (concept_id),
  KEY unique_concept_name_id (concept_id),
  KEY user_who_voided_name (voided_by),
  KEY uesr_who_changed (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_numeric (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  hi_absolute double DEFAULT NULL,
  hi_critical double DEFAULT NULL,
  hi_normal double DEFAULT NULL,
  low_absolute double DEFAULT NULL,
  low_critical double DEFAULT NULL,
  low_normal double DEFAULT NULL,
  units varchar(50) DEFAULT NULL,
  precise tinyint(1) NOT NULL DEFAULT '0',
  display_precision int(11) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_id_index (concept_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_reference_map (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_map_id int(11) NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  concept_id int(11) NOT NULL DEFAULT '0',
  uuid char(38) NOT NULL,
  concept_reference_term_id int(11) NOT NULL,
  concept_map_type_id int(11) NOT NULL DEFAULT '1',
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_map_uuid_index (uuid),
  KEY map_creator (creator),
  KEY map_for_concept (concept_id),
  KEY mapped_concept_map_type (concept_map_type_id),
  KEY mapped_user_changed_ref_term (changed_by),
  KEY mapped_concept_reference_term (concept_reference_term_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_reference_source (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_source_id int(11) NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  description text NOT NULL,
  hl7_code varchar(50) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_source_uuid_index (uuid),
  KEY concept_source_unique_hl7_codes (hl7_code),
  KEY concept_source_creator (creator),
  KEY user_who_voided_concept_source (retired_by),
  KEY unique_hl7_code (hl7_code,retired)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_reference_term (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_reference_term_id int(11) NOT NULL,
  concept_source_id int(11) NOT NULL,
  name varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  code varchar(255) CHARACTER SET utf8 NOT NULL,
  version varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  description varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY mapped_user_creator (creator),
  KEY mapped_user_changed (changed_by),
  KEY mapped_user_retired (retired_by),
  KEY mapped_concept_source (concept_source_id),
  KEY idx_code_concept_reference_term (code)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS concept_reference_term_map (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_reference_term_map_id int(11) NOT NULL,
  term_a_id int(11) NOT NULL,
  term_b_id int(11) NOT NULL,
  a_is_to_b_id int(11) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY mapped_term_a (term_a_id),
  KEY mapped_term_b (term_b_id),
  KEY mapped_concept_map_type_ref_term_map (a_is_to_b_id),
  KEY mapped_user_creator_ref_term_map (creator),
  KEY mapped_user_changed_ref_term_map (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS concept_set (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_set_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  concept_set int(11) NOT NULL DEFAULT '0',
  sort_weight double DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_set_uuid_index (uuid),
  KEY has_a (concept_set),
  KEY user_who_created (creator),
  KEY idx_concept_set_concept (concept_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS concept_stop_word (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  concept_stop_word_id int(11) NOT NULL,
  word varchar(50) CHARACTER SET utf8 NOT NULL,
  locale varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY Unique_StopWord_Key (word,locale)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS cumulative_xrayed1 (
  month_year varchar(37) CHARACTER SET utf8 DEFAULT NULL,
  x_rayed bigint(21) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS dim_concept (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  concept_id int(11) NOT NULL,
  full_name varchar(255) DEFAULT '',
  short_name varchar(255) DEFAULT '',
  default_name varchar(255) DEFAULT '',
  description text,
  retired tinyint(1) NOT NULL DEFAULT '0',
  data_type varchar(255) NOT NULL DEFAULT '',
  class varchar(255) NOT NULL DEFAULT '',
  hi_absolute int(11) DEFAULT NULL,
  hi_critical int(11) DEFAULT NULL,
  hi_normal int(11) DEFAULT NULL,
  low_absolute int(11) DEFAULT NULL,
  low_critical int(11) DEFAULT NULL,
  low_normal int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  version varchar(50) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY concept_id (concept_id,implementation_id),
  KEY uuidx (uuid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_datetime (
  datetime_id bigint(21) NOT NULL AUTO_INCREMENT,
  full_date varchar(50) NOT NULL,
  year int(11) NOT NULL,
  month int(11) NOT NULL,
  date int(11) NOT NULL,
  day_name varchar(50) NOT NULL,
  month_name varchar(50) NOT NULL,
  PRIMARY KEY (datetime_id),
  KEY full_date (full_date)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_encounter (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  encounter_type int(11) NOT NULL,
  encounter_name varchar(50) NOT NULL DEFAULT '',
  description text,
  patient_id int(11) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT NULL,
  provider varchar(255) DEFAULT NULL,
  date_entered datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  creator int(11) DEFAULT NULL,
  date_start datetime DEFAULT NULL,
  date_end datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY encounter_id (encounter_id,implementation_id),
  KEY uuidx (uuid),
  KEY patient_id (patient_id),
  KEY location_id (location_id),
  KEY provider (provider),
  KEY encounter_type (encounter_type)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_lab_test (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  test_type_id int(11) NOT NULL,
  test_name varchar(255) NOT NULL DEFAULT '',
  short_name varchar(20) DEFAULT NULL,
  test_group varchar(20) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  orderer int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  order_reason int(11) DEFAULT NULL,
  order_number varchar(50) NOT NULL,
  order_date datetime DEFAULT NULL,
  lab_reference_number varchar(255) DEFAULT NULL,
  instructions text,
  report_file_path varchar(1024) DEFAULT NULL,
  result_comments varchar(1024) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY test_order (test_order_id),
  KEY test_type (test_type_id),
  KEY patient_id (patient_id),
  KEY orderer (orderer),
  KEY encounter_id (encounter_id),
  KEY lab_reference_number (lab_reference_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_lab_test_result (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  test_type_id int(11) DEFAULT NULL,
  test_attribute_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  attribute_type_name varchar(255) NOT NULL DEFAULT '',
  value_reference varchar(255) DEFAULT NULL,
  datatype varchar(255) DEFAULT NULL,
  lab_reference_number varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid_UNIQUE (uuid),
  KEY test_order_id (test_order_id),
  KEY patient_id (patient_id),
  KEY test_attribute_id (test_attribute_id),
  KEY attribute_type_id (attribute_type_id),
  KEY value_reference (value_reference),
  KEY lab_reference_number (lab_reference_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_location (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  location_id int(11) NOT NULL,
  location_name varchar(255) NOT NULL DEFAULT '',
  description varchar(255) DEFAULT NULL,
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_village varchar(255) DEFAULT NULL,
  state_province varchar(255) DEFAULT NULL,
  postal_code varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL,
  latitude varchar(50) DEFAULT NULL,
  longitude varchar(50) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  parent_location int(11) DEFAULT NULL,
  uuid char(38) DEFAULT NULL,
  location_identifier text,
  primary_contact text,
  fast_location text,
  pmdt_location text,
  aic_location text,
  pet_location text,
  comorbidities_location text,
  childhoodtb_location text,
  location_type text,
  secondary_contact text,
  staff_time text,
  opd_timing text,
  status text,
  primary_contact_name text,
  secondary_contact_name text,
  site_supervisor_system_id text,
  ztts_location text,
  doctor_visit_timing text,
  PRIMARY KEY (surrogate_id),
  KEY location_id (location_id,implementation_id),
  KEY uuidx (uuid),
  KEY location_name (location_name),
  KEY parent (parent_location)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_obs (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) DEFAULT NULL,
  encounter_type int(11) DEFAULT NULL,
  patient_id int(11) DEFAULT NULL,
  identifier varchar(50) DEFAULT NULL,
  provider varchar(50) DEFAULT NULL,
  obs_id int(11) NOT NULL,
  obs_group_id int(11) DEFAULT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  question varchar(255) DEFAULT '',
  obs_datetime datetime NOT NULL,
  location_id int(11) DEFAULT NULL,
  answer longtext,
  value_coded int(11) DEFAULT NULL,
  value_datetime datetime DEFAULT NULL,
  value_numeric double DEFAULT NULL,
  value_text text,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  uuid char(38) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY obs_idx (obs_id,implementation_id),
  KEY identifier (identifier),
  KEY encounter_type (encounter_type),
  KEY concept_id (concept_id),
  KEY question (question),
  KEY location_id (location_id),
  KEY encounter_id (encounter_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_patient (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  patient_id int(11) NOT NULL,
  patient_identifier varchar(50) NOT NULL DEFAULT '',
  enrs varchar(50) DEFAULT NULL,
  external_id varchar(50) DEFAULT NULL,
  district_id varchar(50) DEFAULT NULL,
  gender varchar(50) DEFAULT '',
  birthdate date DEFAULT NULL,
  birthdate_estimated tinyint(1) NOT NULL DEFAULT '0',
  dead tinyint(1) NOT NULL DEFAULT '0',
  first_name varchar(50) DEFAULT NULL,
  middle_name varchar(50) DEFAULT NULL,
  last_name varchar(50) DEFAULT NULL,
  address1 text,
  address2 text,
  city_village text,
  state_province text,
  postal_code text,
  country text,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  uuid char(38) DEFAULT NULL,
  race text,
  birthplace text,
  citizenship text,
  mother_name text,
  marital_status text,
  health_district text,
  health_center text,
  primary_contact text,
  unknown_patient text,
  test_patient text,
  primary_contact_owner text,
  secondary_contact text,
  secondary_contact_owner text,
  ethnicity text,
  education_level text,
  employment_status text,
  occupation text,
  mother_tongue text,
  income_class text,
  national_id text,
  national_id_owner text,
  guardian_name text,
  tertiary_contact text,
  quaternary_contact text,
  treatment_supporter text,
  other_identification_number text,
  transgender text,
  patient_type text,
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id,implementation_id),
  KEY identifier (patient_identifier),
  KEY uuid (uuid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_user (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  username varchar(50) NOT NULL,
  person_id int(11) NOT NULL,
  identifier varchar(255) DEFAULT NULL,
  secret_question varchar(255) DEFAULT NULL,
  secret_answer varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  anonymous text,
  authenticated text,
  call_center_agent text,
  childhoodtb_lab_technician text,
  childhoodtb_medical_officer text,
  childhoodtb_monitor text,
  childhoodtb_nurse text,
  childhoodtb_program_assistant text,
  childhoodtb_program_manager text,
  clinical_coordinator text,
  clinician text,
  community_health_services text,
  comorbidities_associate_diabetologist text,
  comorbidities_counselor text,
  comorbidities_diabetes_educator text,
  comorbidities_eye_screener text,
  comorbidities_foot_screener text,
  comorbidities_health_worker text,
  comorbidities_program_manager text,
  comorbidities_psychologist text,
  counselor text,
  data_entry_operator text,
  diabetes_educator text,
  facility_dot_provider text,
  fast_facilitator text,
  fast_field_supervisor text,
  fast_lab_technician text,
  fast_manager text,
  fast_program_manager text,
  fast_screener text,
  fast_site_manager text,
  field_supervisor text,
  health_worker text,
  implementer text,
  lab_technician text,
  medical_officer text,
  monitor text,
  pet_clinician text,
  pet_field_supervisor text,
  pet_health_worker text,
  pet_program_manager text,
  pet_psychologist text,
  pmdt_diabetes_educator text,
  pmdt_lab_technician text,
  pmdt_program_manager text,
  pmdt_treatment_coordinator text,
  pmdt_treatment_supporter text,
  program_manager text,
  provider text,
  psychologist text,
  referral_site_coordinator text,
  screener text,
  system_developer text,
  treatment_coordinator text,
  treatment_supporter text,
  PRIMARY KEY (surrogate_id),
  KEY user_id (user_id,implementation_id),
  KEY username (username),
  KEY person_id (person_id),
  KEY identifier (identifier),
  KEY uuid (uuid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_user_form (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  user_form_id int(11) NOT NULL,
  user_form_type_id int(11) NOT NULL,
  user_form_type varchar(50) NOT NULL DEFAULT '',
  description text,
  user_id int(11) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT NULL,
  date_entered datetime NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY user_form_id (user_form_id),
  KEY uuidx (uuid),
  KEY user_id (user_form_id,implementation_id),
  KEY location_id (location_id),
  KEY user_form_type_id (user_form_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS dim_user_form_result (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  user_form_type_id int(11) NOT NULL,
  user_form_result_id int(11) NOT NULL,
  user_form_id int(11) NOT NULL,
  element_id int(11) NOT NULL,
  element_name varchar(50) NOT NULL DEFAULT '',
  result text,
  user_id int(11) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT NULL,
  date_entered datetime NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY user_form_id (user_form_id),
  KEY user_form_result_id (user_form_result_id,implementation_id),
  KEY element_id (element_id),
  KEY user_id (user_id),
  KEY location_id (location_id),
  KEY uuid (uuid),
  KEY user_form_type_id (user_form_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS drug (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  drug_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  name varchar(255) DEFAULT NULL,
  combination tinyint(1) NOT NULL DEFAULT '0',
  dosage_form int(11) DEFAULT NULL,
  maximum_daily_dose double DEFAULT NULL,
  minimum_daily_dose double DEFAULT NULL,
  route int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  strength varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY drug_uuid_index (uuid),
  KEY primary_drug_concept (concept_id),
  KEY drug_creator (creator),
  KEY drug_changed_by (changed_by),
  KEY dosage_form_concept (dosage_form),
  KEY drug_retired_by (retired_by),
  KEY route_concept (route)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS drug_ingredient (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  drug_id int(11) NOT NULL,
  ingredient_id int(11) NOT NULL,
  uuid char(38) NOT NULL,
  strength double DEFAULT NULL,
  units int(11) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid (uuid),
  KEY drug_ingredient_units_fk (units),
  KEY drug_ingredient_ingredient_id_fk (ingredient_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS drug_order (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  order_id int(11) NOT NULL DEFAULT '0',
  drug_inventory_id int(11) DEFAULT NULL,
  dose double DEFAULT NULL,
  as_needed tinyint(1) DEFAULT NULL,
  dosing_type varchar(255) DEFAULT NULL,
  quantity double DEFAULT NULL,
  as_needed_condition varchar(255) DEFAULT NULL,
  num_refills int(11) DEFAULT NULL,
  dosing_instructions text,
  duration int(11) DEFAULT NULL,
  duration_units int(11) DEFAULT NULL,
  quantity_units int(11) DEFAULT NULL,
  route int(11) DEFAULT NULL,
  dose_units int(11) DEFAULT NULL,
  frequency int(11) DEFAULT NULL,
  brand_name varchar(255) DEFAULT NULL,
  dispense_as_written tinyint(1) NOT NULL DEFAULT '0',
  drug_non_coded varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY inventory_item (drug_inventory_id),
  KEY drug_order_duration_units_fk (duration_units),
  KEY drug_order_quantity_units (quantity_units),
  KEY drug_order_route_fk (route),
  KEY drug_order_dose_units (dose_units),
  KEY drug_order_frequency_fk (frequency)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS drug_orders_extn (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  id int(11) NOT NULL,
  order_id int(11) DEFAULT NULL,
  group_id int(11) DEFAULT NULL,
  patient_id int(11) DEFAULT NULL,
  drug_name int(11) DEFAULT NULL,
  start_date datetime DEFAULT NULL,
  is_allergic tinyint(1) DEFAULT NULL,
  is_allergic_order_reasons varchar(255) DEFAULT NULL,
  associated_diagnosis int(11) DEFAULT NULL,
  patient_instructions varchar(255) DEFAULT NULL,
  pharmacist_instructions varchar(255) DEFAULT NULL,
  priority int(11) DEFAULT NULL,
  refill int(11) DEFAULT NULL,
  refill_interval int(11) DEFAULT NULL,
  order_status varchar(50) DEFAULT NULL,
  on_hold tinyint(1) DEFAULT NULL,
  for_discard tinyint(1) DEFAULT NULL,
  discontinue_reason int(11) DEFAULT NULL,
  discontinuation_reasons varchar(255) DEFAULT NULL,
  last_dispatch_date datetime DEFAULT NULL,
  drug_expiry_date datetime DEFAULT NULL,
  comment_for_orderer varchar(255) DEFAULT NULL,
  comment_for_patient varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY order_id (order_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS drug_reference_map (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  drug_reference_map_id int(11) NOT NULL,
  drug_id int(11) NOT NULL,
  term_id int(11) NOT NULL,
  concept_map_type int(11) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid (uuid),
  KEY drug_for_drug_reference_map (drug_id),
  KEY concept_reference_term_for_drug_reference_map (term_id),
  KEY concept_map_type_for_drug_reference_map (concept_map_type),
  KEY user_who_changed_drug_reference_map (changed_by),
  KEY drug_reference_map_creator (creator),
  KEY user_who_retired_drug_reference_map (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS encounter (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  encounter_type int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT NULL,
  form_id int(11) DEFAULT NULL,
  encounter_datetime datetime NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  visit_id int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid_UNIQUE (uuid),
  KEY encounter_uuid_index (uuid),
  KEY encounter_datetime_idx (encounter_datetime),
  KEY encounter_ibfk_1 (creator),
  KEY encounter_type_id (encounter_type),
  KEY encounter_form (form_id),
  KEY encounter_location (location_id),
  KEY encounter_patient (patient_id),
  KEY user_who_voided_encounter (voided_by),
  KEY encounter_changed_by (changed_by),
  KEY encounter_visit_id_fk (visit_id),
  KEY encounter_id (encounter_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS encounter_provider (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  encounter_provider_id int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  provider_id int(11) NOT NULL,
  encounter_role_id int(11) NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  date_voided datetime DEFAULT NULL,
  voided_by int(11) DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY encounter_id_fk (encounter_id),
  KEY provider_id_fk (provider_id),
  KEY encounter_role_id_fk (encounter_role_id),
  KEY encounter_provider_creator (creator),
  KEY encounter_provider_changed_by (changed_by),
  KEY encounter_provider_voided_by (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS encounter_role (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  encounter_role_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY encounter_role_unique_name (name),
  KEY encounter_role_creator_fk (creator),
  KEY encounter_role_changed_by_fk (changed_by),
  KEY encounter_role_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS encounter_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  encounter_type_id int(11) NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  description text,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  edit_privilege varchar(255) DEFAULT NULL,
  view_privilege varchar(255) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY encounter_type_unique_name (name),
  KEY encounter_type_uuid_index (uuid),
  KEY encounter_type_retired_status (retired),
  KEY user_who_created_type (creator),
  KEY user_who_retired_encounter_type (retired_by),
  KEY privilege_which_can_view_encounter_type (view_privilege),
  KEY privilege_which_can_edit_encounter_type (edit_privilege),
  KEY uesr_who_changed (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS fact_childtb_dsss (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  Screened_nurse decimal(23,0) DEFAULT NULL,
  Presumptive_nurse decimal(23,0) DEFAULT NULL,
  clinician_evaluation decimal(23,0) DEFAULT NULL,
  Presumptive_Case_Confirmed decimal(23,0) DEFAULT NULL,
  Test_indication decimal(23,0) DEFAULT NULL,
  CBC_Indicated decimal(23,0) DEFAULT NULL,
  ESR_Indicated decimal(23,0) DEFAULT NULL,
  CXR_Indicated decimal(23,0) DEFAULT NULL,
  MT_Indicated decimal(23,0) DEFAULT NULL,
  Ultrasound_Indicated decimal(23,0) DEFAULT NULL,
  HistopathologyFNAC_Indicated decimal(23,0) DEFAULT NULL,
  CT_scan_Indicated decimal(23,0) DEFAULT NULL,
  GXP_Indicated decimal(23,0) DEFAULT NULL,
  TB_Treatment_intiated decimal(23,0) DEFAULT NULL,
  Antibiotic_trial_initiated decimal(23,0) DEFAULT NULL,
  IPT_treatment_initiated decimal(23,0) DEFAULT NULL,
  TB_Treatment_Follow_up decimal(23,0) DEFAULT NULL,
  Antibiotic_trial_Followup decimal(23,0) DEFAULT NULL,
  IPT_follow_up decimal(23,0) DEFAULT NULL,
  End_of_followup decimal(23,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS fact_childtb_sd (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  symptom_screened_nurse decimal(10,0) DEFAULT NULL,
  presumptive_nurse decimal(10,0) DEFAULT NULL,
  percent_presumptive_TB_nurse decimal(10,0) DEFAULT NULL,
  presumptive_MO decimal(10,0) DEFAULT NULL,
  percent_presumptive_MO decimal(10,0) DEFAULT NULL,
  diagnosed_patients decimal(10,0) DEFAULT NULL,
  percent_diagnosed_patients decimal(10,0) DEFAULT NULL,
  treatment_started decimal(10,0) DEFAULT NULL,
  percent_treatment_started decimal(10,0) DEFAULT NULL,
  yield decimal(10,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS fact_childtb_sd2 (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  symptom_screened_nurse decimal(10,0) DEFAULT NULL,
  presumptive_nurse decimal(10,0) DEFAULT NULL,
  percent_presumptive_TB_nurse decimal(10,0) DEFAULT NULL,
  presumptive_MO decimal(10,0) DEFAULT NULL,
  percent_presumptive_MO decimal(10,0) DEFAULT NULL,
  diagnosed_patients decimal(10,0) DEFAULT NULL,
  percent_diagnosed_patients decimal(10,0) DEFAULT NULL,
  treatment_started decimal(10,0) DEFAULT NULL,
  percent_treatment_started decimal(10,0) DEFAULT NULL,
  yield decimal(10,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS fact_childtb_ucab (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  male_under_1 decimal(10,0) DEFAULT NULL,
  male_1to4 decimal(10,0) DEFAULT NULL,
  male_5to9 decimal(10,0) DEFAULT NULL,
  male_10to14 decimal(10,0) DEFAULT NULL,
  female_under_1 decimal(10,0) DEFAULT NULL,
  female_1to4 decimal(10,0) DEFAULT NULL,
  female_5to9 decimal(10,0) DEFAULT NULL,
  female_10to14 decimal(10,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS fact_CHTB_Diagnose (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  Screening_Patients decimal(23,0) DEFAULT NULL,
  Referral_Patients decimal(23,0) DEFAULT NULL,
  TB_Patient decimal(23,0) DEFAULT NULL,
  No_Of_Males_Less_Than_One decimal(23,0) DEFAULT NULL,
  No_Of_Males_Bw_1_4 decimal(23,0) DEFAULT NULL,
  No_Of_Males_Bw_5_9 decimal(23,0) DEFAULT NULL,
  No_Of_Males_Bw_10_14 decimal(23,0) DEFAULT NULL,
  No_Of_Males_Bw_15_18 decimal(23,0) DEFAULT NULL,
  No_Of_Females_Less_Than_One decimal(23,0) DEFAULT NULL,
  No_Of_Females_Bw_1_4 decimal(23,0) DEFAULT NULL,
  No_Of_Females_Bw_5_9 decimal(23,0) DEFAULT NULL,
  No_Of_Females_Bw_10_14 decimal(23,0) DEFAULT NULL,
  No_Of_Females_Bw_15_18 decimal(23,0) DEFAULT NULL,
  Bacteriologically_Confirmed decimal(23,0) DEFAULT NULL,
  CLINICALLY_DIAGNOSED decimal(23,0) DEFAULT NULL,
  Pulmonary_TB_Cases decimal(23,0) DEFAULT NULL,
  EPTB_Cases decimal(23,0) DEFAULT NULL,
  Pulmonary_And_EPTB_Cases decimal(23,0) DEFAULT NULL,
  New_Patients decimal(23,0) DEFAULT NULL,
  Relapse_Patients decimal(23,0) DEFAULT NULL,
  Referred_OR_Transferred_In_Patients decimal(23,0) DEFAULT NULL,
  Tx_After_LTF_Patients decimal(23,0) DEFAULT NULL,
  Tx_After_Failure_Patients decimal(23,0) DEFAULT NULL,
  Category_I decimal(23,0) DEFAULT NULL,
  Category_II decimal(23,0) DEFAULT NULL,
  Category_III decimal(23,0) DEFAULT NULL,
  Treatment_Initiated decimal(23,0) DEFAULT NULL,
  Treatment_Not_Initiated decimal(23,0) DEFAULT NULL,
  Cured decimal(23,0) DEFAULT NULL,
  Treatment_Completed decimal(23,0) DEFAULT NULL,
  Treatment_Failure decimal(23,0) DEFAULT NULL,
  Died decimal(23,0) DEFAULT NULL,
  Transfer_Out decimal(23,0) DEFAULT NULL,
  Referral decimal(23,0) DEFAULT NULL,
  Lost_To_FollowUp decimal(23,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS fact_chtb_diagnostic_investigations (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  Tb_Presumptive_Confirmed decimal(10,2) DEFAULT NULL,
  under_investigation decimal(10,2) DEFAULT NULL,
  patient_missing_investigations decimal(10,2) DEFAULT NULL,
  percentage_patient_missing_investigations decimal(10,2) DEFAULT NULL,
  investigation_incomplete decimal(10,2) DEFAULT NULL,
  percentage_investigation_incomplete decimal(10,2) DEFAULT NULL,
  investigation_complete decimal(10,2) DEFAULT NULL,
  percentage_investigation_complete decimal(10,2) DEFAULT NULL,
  end_of_followup decimal(10,2) DEFAULT NULL,
  percentage_end_of_followup decimal(10,2) DEFAULT NULL,
  on_treatment decimal(10,2) DEFAULT NULL,
  percentage_on_treatment decimal(10,2) DEFAULT NULL,
  tb_diagnosed decimal(10,2) DEFAULT NULL,
  percentage_tb_diagnosed decimal(10,2) DEFAULT NULL,
  antibiotic_patients decimal(10,2) DEFAULT NULL,
  percentage_antibiotic_patients decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS fact_chtb_ltf_antibiotic_treatment (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  Antibiotic_patients decimal(10,2) DEFAULT NULL,
  Refused_Antibiotics decimal(10,2) DEFAULT NULL,
  Percentage_Refused_Antibiotics decimal(10,2) DEFAULT NULL,
  Missed_Antibiotic_Treatment decimal(10,2) DEFAULT NULL,
  Percentage_Missed_Antibiotic_Treatment decimal(10,2) DEFAULT NULL,
  On_Antibioitc_Treatment decimal(10,2) DEFAULT NULL,
  Percentage_On_Antibioitic_Treatment decimal(10,2) DEFAULT NULL,
  End_of_Antibiotic_Treatment decimal(10,2) DEFAULT NULL,
  Percentage_End_of_Antibiotic_Treatment decimal(10,2) DEFAULT NULL,
  TB_Diagnosed decimal(10,2) DEFAULT NULL,
  Percentage_TB_Diagnosed decimal(10,2) DEFAULT NULL,
  TB_Treatment_Initiated decimal(10,2) DEFAULT NULL,
  Percentage_TB_Treatment_Initiated decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS fact_chtb_ltf_clinical_evaluation (
  implementation_id int(11) NOT NULL,
  datetime_id bigint(21) NOT NULL,
  location_id int(11) NOT NULL,
  Total_Presumptives_By_Nurse decimal(10,2) DEFAULT NULL,
  MO_Evaluation decimal(10,2) DEFAULT NULL,
  Percentage_MO_Evaluation decimal(10,2) DEFAULT NULL,
  Presumptives_Missing_Clinical_Evaluation decimal(10,2) DEFAULT NULL,
  Percentage_Presumptives_Missing_Clinical_Evaluation decimal(10,2) DEFAULT NULL,
  Tb_Presumptive_Confirmed decimal(10,2) DEFAULT NULL,
  Percentage_Tb_Presumptive_Confirmed decimal(10,2) DEFAULT NULL,
  Not_Tb_Presumptive decimal(10,2) DEFAULT NULL,
  Percentage_Not_Tb_Presumptive decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS fact_chtb_treatment_initiation (
  implementation_id int(11) NOT NULL DEFAULT '0',
  datetime_id bigint(21) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT NULL,
  tb_patient decimal(23,0) DEFAULT NULL,
  male_lessthan_1 decimal(23,0) DEFAULT NULL,
  male_1_to_4 decimal(23,0) DEFAULT NULL,
  male_5_to_9 decimal(23,0) DEFAULT NULL,
  male_10_to_15 decimal(23,0) DEFAULT NULL,
  female_lessthan_1 decimal(23,0) DEFAULT NULL,
  female_1_to_4 decimal(23,0) DEFAULT NULL,
  female_5_to_9 decimal(23,0) DEFAULT NULL,
  female_10_to_15 decimal(23,0) DEFAULT NULL,
  bacteriologically_confirmed decimal(23,0) DEFAULT NULL,
  clinical_suspicion decimal(23,0) DEFAULT NULL,
  pulmonary_tb decimal(23,0) DEFAULT NULL,
  extrapulmonary_tb decimal(23,0) DEFAULT NULL,
  tb_type_both decimal(23,0) DEFAULT NULL,
  patient_type_new decimal(23,0) DEFAULT NULL,
  patient_type_relapse decimal(23,0) DEFAULT NULL,
  tb_category_cat_1 decimal(23,0) DEFAULT NULL,
  tb_category_cat_2 decimal(23,0) DEFAULT NULL,
  tb_category_cat_3 decimal(23,0) DEFAULT NULL,
  treatment_initiated_yes decimal(23,0) DEFAULT NULL,
  treatment_initiated_no decimal(23,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS field (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  field_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  description text,
  field_type int(11) DEFAULT NULL,
  concept_id int(11) DEFAULT NULL,
  table_name varchar(50) DEFAULT NULL,
  attribute_name varchar(50) DEFAULT NULL,
  default_value text,
  select_multiple tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY field_uuid_index (uuid),
  KEY field_retired_status (retired),
  KEY user_who_changed_field (changed_by),
  KEY concept_for_field (concept_id),
  KEY user_who_created_field (creator),
  KEY type_of_field (field_type),
  KEY user_who_retired_field (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS field_answer (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  field_id int(11) NOT NULL DEFAULT '0',
  answer_id int(11) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  uuid char(38) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY field_answer_uuid_index (uuid),
  KEY field_answer_concept (answer_id),
  KEY user_who_created_field_answer (creator)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS field_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  field_type_id int(11) NOT NULL,
  name varchar(50) DEFAULT NULL,
  description text,
  is_set tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  uuid char(38) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY field_type_uuid_index (uuid),
  KEY user_who_created_field_type (creator)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS form (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  form_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  version varchar(50) NOT NULL DEFAULT '',
  build int(11) DEFAULT NULL,
  published tinyint(1) NOT NULL DEFAULT '0',
  xslt text,
  template text,
  description text,
  encounter_type int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retired_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY form_uuid_index (uuid),
  KEY form_published_index (published),
  KEY form_retired_index (retired),
  KEY form_published_and_retired_index (published,retired),
  KEY user_who_last_changed_form (changed_by),
  KEY user_who_created_form (creator),
  KEY form_encounter_type (encounter_type),
  KEY user_who_retired_form (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS form_field (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  form_field_id int(11) NOT NULL,
  form_id int(11) NOT NULL DEFAULT '0',
  field_id int(11) NOT NULL DEFAULT '0',
  field_number int(11) DEFAULT NULL,
  field_part varchar(5) DEFAULT NULL,
  page_number int(11) DEFAULT NULL,
  parent_form_field int(11) DEFAULT NULL,
  min_occurs int(11) DEFAULT NULL,
  max_occurs int(11) DEFAULT NULL,
  required tinyint(1) NOT NULL DEFAULT '0',
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  sort_weight double DEFAULT NULL,
  uuid char(38) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY form_field_uuid_index (uuid),
  KEY user_who_last_changed_form_field (changed_by),
  KEY user_who_created_form_field (creator),
  KEY field_within_form (field_id),
  KEY form_containing_field (form_id),
  KEY form_field_hierarchy (parent_form_field)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_element (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  element_id int(11) NOT NULL,
  element_name varchar(45) NOT NULL,
  validation_regex varchar(255) DEFAULT NULL,
  data_type varchar(10) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY element_name_UNIQUE (element_name),
  KEY fk_element_users1_idx (created_by),
  KEY fk_element_users2_idx (changed_by),
  KEY fk_element_location1_idx (created_at),
  KEY fk_element_location2_idx (changed_at),
  KEY element_idx (element_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_location (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  location_name varchar(45) NOT NULL,
  category varchar(20) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  address1 varchar(45) DEFAULT NULL,
  address2 varchar(45) DEFAULT NULL,
  address3 varchar(45) DEFAULT NULL,
  city_village varchar(45) DEFAULT NULL,
  state_province varchar(45) DEFAULT NULL,
  country varchar(45) DEFAULT NULL,
  landmark1 varchar(45) DEFAULT NULL,
  landmark2 varchar(45) DEFAULT NULL,
  latitude varchar(45) DEFAULT NULL,
  longitude varchar(45) DEFAULT NULL,
  primary_contact varchar(20) DEFAULT NULL,
  secondary_contact varchar(20) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  fax varchar(20) DEFAULT NULL,
  parent_location int(11) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY location_name_UNIQUE (location_name),
  KEY fk_location_location1_idx (parent_location),
  KEY fk_location_location2_idx (created_at),
  KEY fk_location_location3_idx (changed_at),
  KEY fk_location_users1_idx (created_by),
  KEY fk_location_users2_idx (changed_by),
  KEY location_idx (implementation_id,location_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_location_attribute (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_attribute_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  attribute_value varchar(255) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_location_attribute_location_attribute_type1_idx (attribute_type_id),
  KEY fk_location_attribute_location1_idx (location_id),
  KEY fk_location_attribute_users1_idx (created_by),
  KEY fk_location_attribute_users2_idx (changed_by),
  KEY fk_location_attribute_location2_idx (created_at),
  KEY fk_location_attribute_location3_idx (changed_at),
  KEY location_attribute_idx (location_attribute_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_location_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_attribute_type_id int(11) NOT NULL,
  attribute_name varchar(45) NOT NULL,
  validation_regex varchar(255) DEFAULT NULL,
  required tinyint(4) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  data_type varchar(10) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY attribute_name_UNIQUE (attribute_name),
  KEY fk_location_attribute_type_users1_idx (created_by),
  KEY fk_location_attribute_type_users2_idx (changed_by),
  KEY fk_location_attribute_type_location1_idx (created_at),
  KEY fk_location_attribute_type_location2_idx (changed_at),
  KEY location_attribute_type_id (location_attribute_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_user_attribute (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_attribute_id int(11) NOT NULL,
  attribute_value varchar(255) NOT NULL,
  date_changed datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  changed_at int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  user_attribute_type_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  changed_by int(11) DEFAULT NULL,
  created_by int(11) DEFAULT NULL,
  uuid varchar(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY user_attribute_id (user_attribute_id),
  UNIQUE KEY uuid (uuid),
  KEY fk_user_attribute_user1_idx (user_id),
  KEY fk_user_attribute_user2_idx (created_by),
  KEY fk_user_attribute_location1_idx (created_at),
  KEY fk_user_attribute_user3_idx (changed_by),
  KEY fk_user_attribute_location2_idx (changed_at),
  KEY fk_user_attribute_user_attribute_type_idx (user_attribute_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_user_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_attribute_type_id int(11) NOT NULL,
  attribute_name varchar(45) NOT NULL,
  data_type varchar(10) NOT NULL,
  date_changed datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  description varchar(255) DEFAULT NULL,
  required tinyint(4) NOT NULL,
  uuid varchar(38) NOT NULL,
  validation_regex varchar(255) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  created_by int(11) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY user_attribute_type_id (user_attribute_type_id),
  UNIQUE KEY attribute_name (attribute_name),
  UNIQUE KEY uuid (uuid),
  UNIQUE KEY uuid_2 (uuid),
  KEY fk_user_attribute_type_user1_idx (created_by),
  KEY fk_user_attribute_type_location1_idx (created_at),
  KEY fk_user_attribute_type_user2_idx (changed_by),
  KEY fk_user_attribute_type_location2_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_user_form (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_form_id int(11) NOT NULL,
  user_form_type_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  duration_seconds int(11) DEFAULT NULL,
  date_entered datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_user_form_type1_idx (user_form_type_id),
  KEY fk_user_form_users1_idx (user_id),
  KEY fk_user_form_users2_idx (created_by),
  KEY fk_user_form_users3_idx (changed_by),
  KEY fk_user_form_location1_idx (created_at),
  KEY fk_user_form_location2_idx (changed_at),
  KEY user_form_id (implementation_id,user_form_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_user_form_result (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_form_result_id int(11) NOT NULL,
  user_form_id int(11) NOT NULL,
  element_id int(11) NOT NULL,
  result varchar(5000) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_result_user_form1_idx (element_id),
  KEY fk_user_form_result_location1_idx (created_at),
  KEY fk_user_form_result_location2_idx (changed_at),
  KEY fk_user_form_result_users1_idx (created_by),
  KEY fk_user_form_result_users2_idx (changed_by),
  KEY fk_user_form_result_user_form_idx (user_form_id),
  KEY user_form_result_idx (implementation_id,user_form_result_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_user_form_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_form_type_id int(11) NOT NULL,
  user_form_type varchar(45) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  description varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY user_form_type_UNIQUE (user_form_type),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_type_location1_idx (created_at),
  KEY fk_user_form_type_location2_idx (changed_at),
  KEY fk_user_form_type_users1_idx (created_by),
  KEY fk_user_form_type_users1_idx1 (changed_by),
  KEY fk_user_form_type_users1_idx2 (changed_by),
  KEY user_form_type_id (implementation_id,user_form_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_user_location (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_location_location1_idx (location_id),
  KEY fk_user_location_users1_idx (created_by),
  KEY fk_user_location_users3_idx (changed_by),
  KEY fk_user_location_location2_idx (created_at),
  KEY fk_user_location_location3_idx (changed_at),
  KEY user_id (implementation_id,user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_user_role (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  role_id int(11) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_role_role1_idx (role_id),
  KEY fk_user_role_users2_idx (created_by),
  KEY fk_user_role_users3_idx (changed_by),
  KEY fk_user_role_location1_idx (created_at),
  KEY fk_user_role_location2_idx (changed_at),
  KEY user_idx (implementation_id,user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS gfatm_users (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  username varchar(20) NOT NULL,
  full_name varchar(255) DEFAULT NULL,
  global_data_access tinyint(4) DEFAULT NULL,
  disabled tinyint(4) DEFAULT NULL,
  reason_disabled varchar(255) DEFAULT NULL,
  password_hash varchar(512) DEFAULT NULL,
  password_salt varchar(512) DEFAULT NULL,
  secret_question varchar(255) DEFAULT NULL,
  secret_answer_hash varchar(512) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY username_UNIQUE (username),
  KEY fk_users_location_idx (created_at),
  KEY fk_users_location1_idx (changed_at),
  KEY fk_users_user1_idx (created_by),
  KEY fk_users_users2_idx (changed_by),
  KEY user_idx (implementation_id,user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS lab_afb_culture_dst (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  moxifloxacin_1_0__g_ml_result text CHARACTER SET utf8,
  pyrazinamide text CHARACTER SET utf8,
  other_drug_result text CHARACTER SET utf8,
  isoniazid_1__g_ml_result text CHARACTER SET utf8,
  amikacin text CHARACTER SET utf8,
  levofloxacin text CHARACTER SET utf8,
  rifampicin text CHARACTER SET utf8,
  isoniazid_0_2__g_ml_result text CHARACTER SET utf8,
  ethionamide text CHARACTER SET utf8,
  linezolid text CHARACTER SET utf8,
  capreomycin text CHARACTER SET utf8,
  cycloserine text CHARACTER SET utf8,
  type_of_media_for_dst text CHARACTER SET utf8,
  clofazamine text CHARACTER SET utf8,
  moxifloxacin_2__g_ml_result text CHARACTER SET utf8,
  ofloxacin text CHARACTER SET utf8,
  bedaquiline text CHARACTER SET utf8,
  streptomycin text CHARACTER SET utf8,
  p_aminosalicylic_acid text CHARACTER SET utf8,
  other_drug_name text CHARACTER SET utf8,
  ethambutol text CHARACTER SET utf8,
  kanamycin text CHARACTER SET utf8,
  delamanid text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_afb_smear (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  smear_result text CHARACTER SET utf8,
  number_of_afb_seen_in_one_field text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_audiometry (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  left_ear_audiometry_screen_result text CHARACTER SET utf8,
  right_ear_audiometry_screen_result text CHARACTER SET utf8,
  audiometry_assessment_comment text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_cd4_result (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  notes text CHARACTER SET utf8,
  cd4_count text CHARACTER SET utf8,
  other_test_unit text CHARACTER SET utf8,
  cd4_count_unit text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_creatinine (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  creatinine_result_unit text CHARACTER SET utf8,
  creatinine_result_value text CHARACTER SET utf8,
  other_test_unit text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_culture_done (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  other_culture_medium_type text CHARACTER SET utf8,
  culture_medium_type text CHARACTER SET utf8,
  culture_test_lab_id text CHARACTER SET utf8,
  culture_result text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_ecg_test (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  qtcb_interval__ms_ text CHARACTER SET utf8,
  formula_used text CHARACTER SET utf8,
  qtcf_interval__ms_ text CHARACTER SET utf8,
  rr_interval text CHARACTER SET utf8,
  rhythm text CHARACTER SET utf8,
  heart_rate text CHARACTER SET utf8,
  qtch_interval__ms_ text CHARACTER SET utf8,
  qt_interval text CHARACTER SET utf8,
  ecg_assessment_comment text CHARACTER SET utf8,
  other_rhythm text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_electrolytes (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  calcium_result_unit text CHARACTER SET utf8,
  sodium_result_unit text CHARACTER SET utf8,
  magnesium_result_unit text CHARACTER SET utf8,
  ionized_calcium_result_unit text CHARACTER SET utf8,
  chloride_result_unit text CHARACTER SET utf8,
  potassium_result_value text CHARACTER SET utf8,
  bicarbonate_result_unit text CHARACTER SET utf8,
  sodium_result_value text CHARACTER SET utf8,
  chloride_result_value text CHARACTER SET utf8,
  potassium_result_unit text CHARACTER SET utf8,
  other_chloride_result_unit text CHARACTER SET utf8,
  bicarbonate_result_value text CHARACTER SET utf8,
  other_sodium_result_unit text CHARACTER SET utf8,
  other_ionized_calcium_result_unit text CHARACTER SET utf8,
  other_potassium_result_unit text CHARACTER SET utf8,
  other_magnesium_result_unit text CHARACTER SET utf8,
  magnesium_result_value text CHARACTER SET utf8,
  other_bicarbonate_result_unit text CHARACTER SET utf8,
  calcium_result_value text CHARACTER SET utf8,
  ionized_calcium_result_value text CHARACTER SET utf8,
  other_calcium_result_unit text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_hba1c_test (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  other_test_unit text CHARACTER SET utf8,
  hba1c_result_value text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_hepb_result (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  hepatitis_b_surface_antigen_test_result_ text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_hepc_result (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  hepatitis_c_antibody_result text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_hiv_test (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  notes text CHARACTER SET utf8,
  hiv_result text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_lfts (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  ast_sgot_result_unit text CHARACTER SET utf8,
  total_bilirubin_result_unit text CHARACTER SET utf8,
  alkaline_phosphatase_result_unit text CHARACTER SET utf8,
  total_bilirubin_result_value text CHARACTER SET utf8,
  alt_sgpt_result_unit text CHARACTER SET utf8,
  alkaline_phosphatase_result_value text CHARACTER SET utf8,
  gamma_glutamyl_tranferase__ggt__result_unit text CHARACTER SET utf8,
  ast_sgot_result_value text CHARACTER SET utf8,
  other_alkaline_phosphatase_result_unit text CHARACTER SET utf8,
  other_total_bilirubin_result_unit text CHARACTER SET utf8,
  gamma_glutamyl_tranferase__ggt__result_value text CHARACTER SET utf8,
  other_alt_sgpt_result_unit text CHARACTER SET utf8,
  other_ast_sgot_result_unit text CHARACTER SET utf8,
  other_gamma_glutamyl_tranferase__ggt__result_unit text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_qft (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  tb2 text CHARACTER SET utf8,
  nil text CHARACTER SET utf8,
  mitogen_nil text CHARACTER SET utf8,
  tb1_nil text CHARACTER SET utf8,
  run_number text CHARACTER SET utf8,
  mitogen text CHARACTER SET utf8,
  tb2_nil text CHARACTER SET utf8,
  valid_test text CHARACTER SET utf8,
  run_date text CHARACTER SET utf8,
  result text CHARACTER SET utf8,
  tb1 text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_refer_esr (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  esr_result_unit text CHARACTER SET utf8,
  esr_result_value text CHARACTER SET utf8,
  other_esr_result_unit text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_tsh (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  thyroid_stimulating_hormone__tsh__result_unit text CHARACTER SET utf8,
  thyroid_stimulating_hormone__tsh__value text CHARACTER SET utf8,
  other_unit text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS lab_urea_value (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  orderer int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) NOT NULL,
  lab_reference_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  urea_result_unit text CHARACTER SET utf8,
  urea_result_value text CHARACTER SET utf8,
  other_test_unit text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY patient_id (patient_id),
  KEY test_order_id (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS location (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  description varchar(255) DEFAULT NULL,
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_village varchar(255) DEFAULT NULL,
  state_province varchar(255) DEFAULT NULL,
  postal_code varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL,
  latitude varchar(50) DEFAULT NULL,
  longitude varchar(50) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  county_district varchar(255) DEFAULT NULL,
  address3 varchar(255) DEFAULT NULL,
  address4 varchar(255) DEFAULT NULL,
  address5 varchar(255) DEFAULT NULL,
  address6 varchar(255) DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  parent_location int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY location_uuid_index (uuid),
  KEY name_of_location (name),
  KEY location_retired_status (retired),
  KEY user_who_created_location (creator),
  KEY user_who_retired_location (retired_by),
  KEY parent_location (parent_location),
  KEY location_changed_by (changed_by),
  KEY location_idx (location_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS location_attribute (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_attribute_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference text NOT NULL,
  uuid char(38) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY location_attribute_location_fk (location_id),
  KEY location_attribute_attribute_type_id_fk (attribute_type_id),
  KEY location_attribute_creator_fk (creator),
  KEY location_attribute_changed_by_fk (changed_by),
  KEY location_attribute_voided_by_fk (voided_by),
  KEY location_attribute_idx (location_attribute_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS location_attribute_merged (
  implementation_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  location_identifier text CHARACTER SET utf8,
  primary_contact text CHARACTER SET utf8,
  fast_location text CHARACTER SET utf8,
  pmdt_location text CHARACTER SET utf8,
  aic_location text CHARACTER SET utf8,
  pet_location text CHARACTER SET utf8,
  comorbidities_location text CHARACTER SET utf8,
  childhoodtb_location text CHARACTER SET utf8,
  location_type text CHARACTER SET utf8,
  secondary_contact text CHARACTER SET utf8,
  staff_time text CHARACTER SET utf8,
  opd_timing text CHARACTER SET utf8,
  status text CHARACTER SET utf8,
  primary_contact_name text CHARACTER SET utf8,
  secondary_contact_name text CHARACTER SET utf8,
  site_supervisor_system_id text CHARACTER SET utf8,
  ztts_location text CHARACTER SET utf8,
  doctor_visit_timing text CHARACTER SET utf8,
  BLANK char(0) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS location_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_attribute_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  datatype varchar(255) DEFAULT NULL,
  datatype_config text,
  preferred_handler varchar(255) DEFAULT NULL,
  handler_config text,
  min_occurs int(11) NOT NULL,
  max_occurs int(11) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY location_attribute_type_unique_name (name),
  KEY location_attribute_type_creator_fk (creator),
  KEY location_attribute_type_changed_by_fk (changed_by),
  KEY location_attribute_type_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS location_tag (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_tag_id int(11) NOT NULL,
  name varchar(50) NOT NULL,
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY location_tag_uuid_index (uuid),
  KEY location_tag_creator (creator),
  KEY location_tag_retired_by (retired_by),
  KEY location_tag_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS location_tag_map (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  location_tag_id int(11) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY location_tag_map_tag (location_tag_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS obs (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  obs_id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) DEFAULT NULL,
  order_id int(11) DEFAULT NULL,
  obs_datetime datetime NOT NULL,
  location_id int(11) DEFAULT NULL,
  obs_group_id int(11) DEFAULT NULL,
  accession_number varchar(255) DEFAULT NULL,
  value_group_id int(11) DEFAULT NULL,
  value_coded int(11) DEFAULT NULL,
  value_coded_name_id int(11) DEFAULT NULL,
  value_drug int(11) DEFAULT NULL,
  value_datetime datetime DEFAULT NULL,
  value_numeric double DEFAULT NULL,
  value_modifier varchar(2) DEFAULT NULL,
  value_text text,
  value_complex varchar(1000) DEFAULT NULL,
  comments varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  previous_version int(11) DEFAULT NULL,
  form_namespace_and_path varchar(255) DEFAULT NULL,
  status varchar(16) NOT NULL DEFAULT 'FINAL',
  interpretation varchar(32) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid_UNIQUE (uuid),
  KEY obs_uuid_index (uuid),
  KEY obs_datetime_idx (obs_datetime),
  KEY obs_concept (concept_id),
  KEY obs_enterer (creator),
  KEY encounter_observations (encounter_id),
  KEY obs_location (location_id),
  KEY obs_grouping_id (obs_group_id),
  KEY obs_order (order_id),
  KEY person_obs (person_id),
  KEY answer_concept (value_coded),
  KEY obs_name_of_coded_value (value_coded_name_id),
  KEY answer_concept_drug (value_drug),
  KEY user_who_voided_obs (voided_by),
  KEY previous_version (previous_version),
  KEY obs_idx (obs_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS orders (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  order_id int(11) NOT NULL,
  order_type_id int(11) NOT NULL DEFAULT '0',
  concept_id int(11) NOT NULL DEFAULT '0',
  orderer int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  instructions text,
  date_activated datetime DEFAULT NULL,
  auto_expire_date datetime DEFAULT NULL,
  date_stopped datetime DEFAULT NULL,
  order_reason int(11) DEFAULT NULL,
  order_reason_non_coded varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  patient_id int(11) NOT NULL,
  accession_number varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  urgency varchar(50) NOT NULL DEFAULT 'ROUTINE',
  order_number varchar(50) NOT NULL,
  previous_order_id int(11) DEFAULT NULL,
  order_action varchar(50) NOT NULL,
  comment_to_fulfiller varchar(1024) DEFAULT NULL,
  care_setting int(11) NOT NULL,
  scheduled_date datetime DEFAULT NULL,
  order_group_id int(11) DEFAULT NULL,
  sort_weight double DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY orders_uuid_index (uuid),
  KEY order_creator (creator),
  KEY orders_in_encounter (encounter_id),
  KEY type_of_order (order_type_id),
  KEY order_for_patient (patient_id),
  KEY user_who_voided_order (voided_by),
  KEY previous_order_id_order_id (previous_order_id),
  KEY orders_care_setting (care_setting),
  KEY discontinued_because (order_reason),
  KEY fk_orderer_provider (orderer),
  KEY orders_order_group_id_fk (order_group_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS patient (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  patient_id int(11) NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY user_who_changed_pat (changed_by),
  KEY user_who_created_patient (creator),
  KEY user_who_voided_patient (voided_by),
  KEY patient_idx (patient_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS patient_identifier (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  patient_identifier_id int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  identifier varchar(50) NOT NULL DEFAULT '',
  identifier_type int(11) NOT NULL DEFAULT '0',
  preferred tinyint(1) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuid_UNIQUE (uuid),
  KEY patient_identifier_uuid_index (uuid),
  KEY identifier_name (identifier),
  KEY idx_patient_identifier_patient (patient_id),
  KEY identifier_creator (creator),
  KEY defines_identifier_type (identifier_type),
  KEY patient_identifier_ibfk_2 (location_id),
  KEY identifier_voider (voided_by),
  KEY patient_identifier_changed_by (changed_by),
  KEY patient_identifier_idx (patient_identifier_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS patient_identifier_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  patient_identifier_type_id int(11) NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  description text,
  format varchar(255) DEFAULT NULL,
  check_digit tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  required tinyint(1) NOT NULL DEFAULT '0',
  format_description varchar(255) DEFAULT NULL,
  validator varchar(200) DEFAULT NULL,
  location_behavior varchar(50) DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  uniqueness_behavior varchar(50) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY patient_identifier_type_uuid_index (uuid),
  KEY patient_identifier_type_retired_status (retired),
  KEY type_creator (creator),
  KEY user_who_retired_patient_identifier_type (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS patient_latest_identifier (
  implementation_id int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  identifier_type int(11) NOT NULL DEFAULT '0',
  identifier varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  max_patient_identifier_id int(11),
  KEY identifier_id_index (patient_id,identifier_type,max_patient_identifier_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS patient_program (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  patient_program_id int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  program_id int(11) NOT NULL DEFAULT '0',
  date_enrolled datetime DEFAULT NULL,
  date_completed datetime DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  outcome_concept_id int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY patient_program_uuid_index (uuid),
  KEY user_who_changed (changed_by),
  KEY patient_program_creator (creator),
  KEY patient_in_program (patient_id),
  KEY program_for_patient (program_id),
  KEY user_who_voided_patient_program (voided_by),
  KEY patient_program_location_id (location_id),
  KEY patient_program_outcome_concept_id_fk (outcome_concept_id),
  KEY patient_program_idx (patient_program_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS patient_state (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  patient_state_id int(11) NOT NULL,
  patient_program_id int(11) NOT NULL DEFAULT '0',
  state int(11) NOT NULL DEFAULT '0',
  start_date date DEFAULT NULL,
  end_date date DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY patient_state_uuid_index (uuid),
  KEY patient_state_changer (changed_by),
  KEY patient_state_creator (creator),
  KEY patient_program_for_state (patient_program_id),
  KEY state_for_patient (state),
  KEY patient_state_voider (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS person (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  gender varchar(50) DEFAULT '',
  birthdate date DEFAULT NULL,
  birthdate_estimated tinyint(1) NOT NULL DEFAULT '0',
  dead tinyint(1) NOT NULL DEFAULT '0',
  death_date datetime DEFAULT NULL,
  cause_of_death int(11) DEFAULT NULL,
  creator int(11) DEFAULT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  deathdate_estimated tinyint(1) NOT NULL DEFAULT '0',
  birthtime time DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY person_uuid_index (uuid),
  KEY person_birthdate (birthdate),
  KEY person_death_date (death_date),
  KEY person_died_because (cause_of_death),
  KEY user_who_changed_person (changed_by),
  KEY user_who_created_person (creator),
  KEY user_who_voided_person (voided_by),
  KEY person_id (person_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS person_address (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  person_address_id int(11) NOT NULL,
  person_id int(11) DEFAULT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_village varchar(255) DEFAULT NULL,
  state_province varchar(255) DEFAULT NULL,
  postal_code varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL,
  latitude varchar(50) DEFAULT NULL,
  longitude varchar(50) DEFAULT NULL,
  start_date datetime DEFAULT NULL,
  end_date datetime DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  county_district varchar(255) DEFAULT NULL,
  address3 varchar(255) DEFAULT NULL,
  address4 varchar(255) DEFAULT NULL,
  address5 varchar(255) DEFAULT NULL,
  address6 varchar(255) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY person_address_uuid_index (uuid),
  KEY patient_address_creator (creator),
  KEY address_for_person (person_id),
  KEY patient_address_void (voided_by),
  KEY person_address_changed_by (changed_by),
  KEY person_address_idx (person_address_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS person_attribute (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  person_attribute_id int(11) NOT NULL,
  person_id int(11) NOT NULL DEFAULT '0',
  value varchar(50) NOT NULL DEFAULT '',
  person_attribute_type_id int(11) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY person_attribute_uuid_index (uuid),
  KEY attribute_changer (changed_by),
  KEY attribute_creator (creator),
  KEY defines_attribute_type (person_attribute_type_id),
  KEY identifies_person (person_id),
  KEY attribute_voider (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS person_attribute_merged (
  implementation_id int(11) NOT NULL,
  person_id int(11) NOT NULL DEFAULT '0',
  race text CHARACTER SET utf8,
  birthplace text CHARACTER SET utf8,
  citizenship text CHARACTER SET utf8,
  mother_name text CHARACTER SET utf8,
  marital_status text CHARACTER SET utf8,
  health_district text CHARACTER SET utf8,
  health_center text CHARACTER SET utf8,
  primary_contact text CHARACTER SET utf8,
  unknown_patient text CHARACTER SET utf8,
  test_patient text CHARACTER SET utf8,
  primary_contact_owner text CHARACTER SET utf8,
  secondary_contact text CHARACTER SET utf8,
  secondary_contact_owner text CHARACTER SET utf8,
  ethnicity text CHARACTER SET utf8,
  education_level text CHARACTER SET utf8,
  employment_status text CHARACTER SET utf8,
  occupation text CHARACTER SET utf8,
  mother_tongue text CHARACTER SET utf8,
  income_class text CHARACTER SET utf8,
  national_id text CHARACTER SET utf8,
  national_id_owner text CHARACTER SET utf8,
  guardian_name text CHARACTER SET utf8,
  tertiary_contact text CHARACTER SET utf8,
  quaternary_contact text CHARACTER SET utf8,
  treatment_supporter text CHARACTER SET utf8,
  other_identification_number text CHARACTER SET utf8,
  transgender text CHARACTER SET utf8,
  patient_type text CHARACTER SET utf8,
  email_address text CHARACTER SET utf8,
  BLANK char(0) CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (implementation_id,person_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS person_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  person_attribute_type_id int(11) NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  description text,
  format varchar(50) DEFAULT NULL,
  foreign_key int(11) DEFAULT NULL,
  searchable tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  edit_privilege varchar(255) DEFAULT NULL,
  sort_weight double DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY person_attribute_type_uuid_index (uuid),
  KEY attribute_is_searchable (searchable),
  KEY name_of_attribute (name),
  KEY person_attribute_type_retired_status (retired),
  KEY attribute_type_changer (changed_by),
  KEY attribute_type_creator (creator),
  KEY user_who_retired_person_attribute_type (retired_by),
  KEY privilege_which_can_edit (edit_privilege)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS person_latest_address (
  surrogate_id int(11) NOT NULL DEFAULT '0',
  implementation_id int(11) NOT NULL,
  person_address_id int(11) NOT NULL,
  person_id int(11) DEFAULT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  address1 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  address2 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  city_village varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  state_province varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  postal_code varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  country varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  latitude varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  longitude varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  start_date datetime DEFAULT NULL,
  end_date datetime DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  county_district varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  address3 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  address4 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  address5 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  address6 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY person_index (person_id,person_address_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS person_latest_name (
  surrogate_id int(11) NOT NULL DEFAULT '0',
  implementation_id int(11) NOT NULL,
  person_name_id int(11) NOT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  person_id int(11) NOT NULL,
  prefix varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  given_name varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  middle_name varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  family_name_prefix varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  family_name varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  family_name2 varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  family_name_suffix varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  degree varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY person_index (person_id,person_name_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS person_name (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  person_name_id int(11) NOT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  person_id int(11) NOT NULL,
  prefix varchar(50) DEFAULT NULL,
  given_name varchar(50) DEFAULT NULL,
  middle_name varchar(50) DEFAULT NULL,
  family_name_prefix varchar(50) DEFAULT NULL,
  family_name varchar(50) DEFAULT NULL,
  family_name2 varchar(50) DEFAULT NULL,
  family_name_suffix varchar(50) DEFAULT NULL,
  degree varchar(50) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY person_name_uuid_index (uuid),
  KEY first_name (given_name),
  KEY last_name (family_name),
  KEY middle_name (middle_name),
  KEY family_name2 (family_name2),
  KEY user_who_made_name (creator),
  KEY name_for_person (person_id),
  KEY user_who_voided_name (voided_by),
  KEY person_name_idx (person_name_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS privilege (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  privilege varchar(255) NOT NULL,
  description text,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY privilege_uuid_index (uuid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS program (
  program_id int(11) NOT NULL AUTO_INCREMENT,
  concept_id int(11) NOT NULL DEFAULT '0',
  outcomes_concept_id int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  name varchar(50) NOT NULL,
  description text,
  uuid char(38) NOT NULL,
  PRIMARY KEY (program_id),
  UNIQUE KEY program_uuid_index (uuid),
  KEY user_who_changed_program (changed_by),
  KEY program_concept (concept_id),
  KEY program_creator (creator),
  KEY program_outcomes_concept_id_fk (outcomes_concept_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS provider (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  provider_id int(11) NOT NULL,
  person_id int(11) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  identifier varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY provider_changed_by_fk (changed_by),
  KEY provider_person_id_fk (person_id),
  KEY provider_retired_by_fk (retired_by),
  KEY provider_creator_fk (creator),
  KEY provider_id (provider_id),
  KEY identifier (identifier)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS provider_attribute (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  provider_attribute_id int(11) NOT NULL,
  provider_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference text NOT NULL,
  uuid char(38) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY provider_attribute_provider_fk (provider_id),
  KEY provider_attribute_attribute_type_id_fk (attribute_type_id),
  KEY provider_attribute_creator_fk (creator),
  KEY provider_attribute_changed_by_fk (changed_by),
  KEY provider_attribute_voided_by_fk (voided_by),
  KEY provider_attribute_provider_attribute_idx (provider_attribute_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS provider_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  provider_attribute_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  datatype varchar(255) DEFAULT NULL,
  datatype_config text,
  preferred_handler varchar(255) DEFAULT NULL,
  handler_config text,
  min_occurs int(11) NOT NULL,
  max_occurs int(11) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY provider_attribute_type_creator_fk (creator),
  KEY provider_attribute_type_changed_by_fk (changed_by),
  KEY provider_attribute_type_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS relationship (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  relationship_id int(11) NOT NULL,
  person_a int(11) NOT NULL,
  relationship int(11) NOT NULL DEFAULT '0',
  person_b int(11) NOT NULL,
  start_date datetime DEFAULT NULL,
  end_date datetime DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY relationship_uuid_index (uuid),
  KEY relation_creator (creator),
  KEY person_a_is_person (person_a),
  KEY person_b_is_person (person_b),
  KEY relationship_type_id (relationship),
  KEY relation_voider (voided_by),
  KEY relationship_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS relationship_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  relationship_type_id int(11) NOT NULL,
  a_is_to_b varchar(50) NOT NULL,
  b_is_to_a varchar(50) NOT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  weight int(11) NOT NULL DEFAULT '0',
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY relationship_type_uuid_index (uuid),
  KEY user_who_created_rel (creator),
  KEY user_who_retired_relationship_type (retired_by),
  KEY relationship_type_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS role (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  role varchar(50) NOT NULL DEFAULT '',
  description varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY role_uuid_index (uuid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS role_privilege (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  role varchar(50) NOT NULL DEFAULT '',
  privilege varchar(255) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY role_privilege_to_role (role)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS role_role (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  parent_role varchar(50) NOT NULL DEFAULT '',
  child_role varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY inherited_role (child_role)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_commonlabtest_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_attribute_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_attribute_test_fk (test_order_id),
  KEY commonlabtest_attribute_attribute_type_fk (attribute_type_id),
  KEY commonlabtest_attribute_creator_fk (creator),
  KEY commonlabtest_attribute_changed_by_fk (changed_by),
  KEY commonlabtest_attribute_voided_by_fk (voided_by),
  KEY commonlabtest_attribute_id_idx (test_attribute_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_commonlabtest_attribute_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_attribute_type_id int(11) NOT NULL,
  test_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  datatype varchar(255) NOT NULL,
  min_occurs int(11) NOT NULL DEFAULT '0',
  max_occurs int(11) DEFAULT NULL,
  datatype_config text,
  handler_config text,
  sort_weight double DEFAULT NULL,
  description text NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  preferred_handler varchar(255) DEFAULT NULL,
  hint varchar(1024) DEFAULT NULL,
  group_name varchar(255) DEFAULT NULL,
  multiset_name varchar(255) DEFAULT NULL,
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_attribute_type_test_type_fk (test_type_id),
  KEY commonlabtest_attribute_type_creator_fk (creator),
  KEY commonlabtest_attribute_type_changed_by_fk (changed_by),
  KEY commonlabtest_attribute_type_retired_by_fk (retired_by),
  KEY commonlabtest_attribute_type_idx (test_attribute_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_commonlabtest_sample (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_sample_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  specimen_type int(11) NOT NULL,
  specimen_site int(11) DEFAULT NULL,
  is_expirable tinyint(1) NOT NULL DEFAULT '1',
  expiry_date datetime DEFAULT NULL,
  lab_sample_identifier varchar(50) DEFAULT NULL,
  collector int(11) NOT NULL DEFAULT '0',
  status varchar(50) DEFAULT NULL,
  comments varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  collection_date datetime DEFAULT NULL,
  processed_date datetime DEFAULT NULL,
  quantity double DEFAULT NULL,
  units varchar(255) DEFAULT NULL,
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_sample_test_fk (test_order_id),
  KEY commonlabtest_sample_specimen_type_fk (specimen_type),
  KEY commonlabtest_sample_specimen_site_fk (specimen_site),
  KEY commonlabtest_sample_collector_fk (collector),
  KEY commonlabtest_sample_creator_fk (creator),
  KEY commonlabtest_sample_changed_by_fk (changed_by),
  KEY commonlabtest_sample_voided_by_fk (voided_by),
  KEY commonlabtest_sample_idx (test_sample_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_commonlabtest_test (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_order_id int(11) NOT NULL,
  test_type_id int(11) NOT NULL,
  lab_reference_number varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  instructions varchar(512) DEFAULT NULL,
  report_file_path varchar(1024) DEFAULT NULL,
  result_comments varchar(1024) DEFAULT NULL,
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_test_type_fk (test_type_id),
  KEY commonlabtest_test_creator_fk (creator),
  KEY commonlabtest_test_changed_by_fk (changed_by),
  KEY commonlabtest_test_voided_by_fk (voided_by),
  KEY commonlabtest_test_order_idx (test_order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_commonlabtest_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  test_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  short_name varchar(20) DEFAULT NULL,
  test_group varchar(20) NOT NULL,
  requires_specimen tinyint(1) NOT NULL DEFAULT '1',
  reference_concept_id int(11) NOT NULL,
  description text NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuid (uuid),
  KEY commonlabtest_type_creator_fk (creator),
  KEY commonlabtest_type_reference_concept_fk (reference_concept_id),
  KEY commonlabtest_type_changed_by_fk (changed_by),
  KEY commonlabtest_type_retired_by_fk (retired_by),
  KEY commonlabtest_type_idx (test_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_concept (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_id int(11) NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  short_name varchar(255) DEFAULT NULL,
  description text,
  form_text text,
  datatype_id int(11) NOT NULL DEFAULT '0',
  class_id int(11) NOT NULL DEFAULT '0',
  is_set tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  version varchar(50) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY concept_uuid_index (uuid),
  KEY concept_classes (class_id),
  KEY concept_creator (creator),
  KEY concept_datatypes (datatype_id),
  KEY user_who_changed_concept (changed_by),
  KEY concept_code (version),
  KEY concept_ndx (version),
  KEY user_who_retired_concept (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_concept_answer (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_answer_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  answer_concept int(11) DEFAULT NULL,
  answer_drug int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  uuid char(38) NOT NULL,
  sort_weight double DEFAULT NULL,
  KEY concept_answer_uuid_index (uuid),
  KEY answer_creator (creator),
  KEY answer (answer_concept),
  KEY answers_for_concept (concept_id),
  KEY answer_answer_drug_fk (answer_drug)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_concept_class (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_class_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY concept_class_uuid_index (uuid),
  KEY concept_class_creator (creator),
  KEY user_who_retired_concept_class (retired_by),
  KEY concept_class_retired_status (retired)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_concept_datatype (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_datatype_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  hl7_abbreviation varchar(3) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY concept_datatype_uuid_index (uuid),
  KEY concept_datatype_creator (creator),
  KEY user_who_retired_concept_datatype (retired_by),
  KEY concept_datatype_retired_status (retired)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_concept_description (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_description_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  description text NOT NULL,
  locale varchar(50) NOT NULL DEFAULT '',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY concept_description_uuid_index (uuid),
  KEY concept_being_described (concept_id),
  KEY user_who_created_description (creator),
  KEY user_who_changed_description (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_concept_map_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_map_type_id int(11) NOT NULL,
  name varchar(255) CHARACTER SET utf8 NOT NULL,
  description varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  is_hidden tinyint(1) DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  KEY name (name),
  KEY uuid (uuid),
  KEY mapped_user_creator_concept_map_type (creator),
  KEY mapped_user_changed_concept_map_type (changed_by),
  KEY mapped_user_retired_concept_map_type (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS tmp_concept_name (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_id int(11) DEFAULT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  locale varchar(50) NOT NULL DEFAULT '',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  concept_name_id int(11) NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  concept_name_type varchar(50) DEFAULT NULL,
  locale_preferred tinyint(1) DEFAULT '0',
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  KEY concept_name_id (concept_name_id),
  KEY concept_name_uuid_index (uuid),
  KEY user_who_created_name (creator),
  KEY name_of_concept (name),
  KEY concept_id (concept_id),
  KEY unique_concept_name_id (concept_id),
  KEY user_who_voided_name (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_concept_numeric (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  hi_absolute double DEFAULT NULL,
  hi_critical double DEFAULT NULL,
  hi_normal double DEFAULT NULL,
  low_absolute double DEFAULT NULL,
  low_critical double DEFAULT NULL,
  low_normal double DEFAULT NULL,
  units varchar(50) DEFAULT NULL,
  precise tinyint(1) NOT NULL DEFAULT '0',
  display_precision int(11) DEFAULT NULL,
  KEY concept_id_index (concept_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_concept_set (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  concept_set_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  concept_set int(11) NOT NULL DEFAULT '0',
  sort_weight double DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  uuid char(38) NOT NULL,
  KEY concept_set_uuid_index (uuid),
  KEY has_a (concept_set),
  KEY user_who_created (creator),
  KEY idx_concept_set_concept (concept_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_dim_encounter (
  surrogate_id int(11) NOT NULL DEFAULT '0',
  implementation_id int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  encounter_type int(11) NOT NULL,
  encounter_name varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  description text CHARACTER SET utf8,
  patient_id int(11) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT NULL,
  provider varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  date_entered datetime NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_start datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  date_end datetime NOT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_dim_patient (
  surrogate_id int(11) NOT NULL DEFAULT '0',
  implementation_id int(11) NOT NULL,
  patient_id int(11) NOT NULL,
  patient_identifier varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  enrs varchar(50) CHARACTER SET utf8 DEFAULT '',
  external_id varchar(50) CHARACTER SET utf8 DEFAULT '',
  district_id varchar(50) CHARACTER SET utf8 DEFAULT '',
  gender varchar(50) CHARACTER SET utf8 DEFAULT '',
  birthdate date DEFAULT NULL,
  birthdate_estimated tinyint(1) NOT NULL DEFAULT '0',
  dead tinyint(1) NOT NULL DEFAULT '0',
  first_name varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  middle_name varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  last_name varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  address1 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  address2 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  city_village varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  state_province varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  postal_code varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  country varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  race text CHARACTER SET utf8,
  birthplace text CHARACTER SET utf8,
  citizenship text CHARACTER SET utf8,
  mother_name text CHARACTER SET utf8,
  marital_status text CHARACTER SET utf8,
  health_district text CHARACTER SET utf8,
  health_center text CHARACTER SET utf8,
  primary_contact text CHARACTER SET utf8,
  unknown_patient text CHARACTER SET utf8,
  test_patient text CHARACTER SET utf8,
  primary_contact_owner text CHARACTER SET utf8,
  secondary_contact text CHARACTER SET utf8,
  secondary_contact_owner text CHARACTER SET utf8,
  ethnicity text CHARACTER SET utf8,
  education_level text CHARACTER SET utf8,
  employment_status text CHARACTER SET utf8,
  occupation text CHARACTER SET utf8,
  mother_tongue text CHARACTER SET utf8,
  income_class text CHARACTER SET utf8,
  national_id text CHARACTER SET utf8,
  national_id_owner text CHARACTER SET utf8,
  guardian_name text CHARACTER SET utf8,
  tertiary_contact text CHARACTER SET utf8,
  quaternary_contact text CHARACTER SET utf8,
  treatment_supporter text CHARACTER SET utf8,
  other_identification_number text CHARACTER SET utf8,
  transgender text CHARACTER SET utf8,
  patient_type text CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_drug (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  drug_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  name varchar(255) DEFAULT NULL,
  combination tinyint(1) NOT NULL DEFAULT '0',
  dosage_form int(11) DEFAULT NULL,
  maximum_daily_dose double DEFAULT NULL,
  minimum_daily_dose double DEFAULT NULL,
  route int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  strength varchar(255) DEFAULT NULL,
  KEY primary_drug_concept (concept_id),
  KEY drug_creator (creator),
  KEY drug_changed_by (changed_by),
  KEY dosage_form_concept (dosage_form),
  KEY drug_retired_by (retired_by),
  KEY route_concept (route)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_drug_ingredient (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  drug_id int(11) NOT NULL,
  ingredient_id int(11) NOT NULL,
  uuid char(38) NOT NULL,
  strength double DEFAULT NULL,
  units int(11) DEFAULT NULL,
  KEY drug_ingredient_units_fk (units),
  KEY drug_ingredient_ingredient_id_fk (ingredient_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_drug_order (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  order_id int(11) NOT NULL DEFAULT '0',
  drug_inventory_id int(11) DEFAULT NULL,
  dose double DEFAULT NULL,
  as_needed tinyint(1) DEFAULT NULL,
  dosing_type varchar(255) DEFAULT NULL,
  quantity double DEFAULT NULL,
  as_needed_condition varchar(255) DEFAULT NULL,
  num_refills int(11) DEFAULT NULL,
  dosing_instructions text,
  duration int(11) DEFAULT NULL,
  duration_units int(11) DEFAULT NULL,
  quantity_units int(11) DEFAULT NULL,
  route int(11) DEFAULT NULL,
  dose_units int(11) DEFAULT NULL,
  frequency int(11) DEFAULT NULL,
  brand_name varchar(255) DEFAULT NULL,
  dispense_as_written tinyint(1) NOT NULL DEFAULT '0',
  drug_non_coded varchar(255) DEFAULT NULL,
  KEY inventory_item (drug_inventory_id),
  KEY drug_order_duration_units_fk (duration_units),
  KEY drug_order_quantity_units (quantity_units),
  KEY drug_order_route_fk (route),
  KEY drug_order_dose_units (dose_units),
  KEY drug_order_frequency_fk (frequency)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_drug_orders_extn (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  id int(11) NOT NULL,
  order_id int(11) DEFAULT NULL,
  group_id int(11) DEFAULT NULL,
  patient_id int(11) DEFAULT NULL,
  drug_name int(11) DEFAULT NULL,
  start_date datetime DEFAULT NULL,
  is_allergic tinyint(1) DEFAULT NULL,
  is_allergic_order_reasons varchar(255) DEFAULT NULL,
  associated_diagnosis int(11) DEFAULT NULL,
  patient_instructions varchar(255) DEFAULT NULL,
  pharmacist_instructions varchar(255) DEFAULT NULL,
  priority int(11) DEFAULT NULL,
  refill int(11) DEFAULT NULL,
  refill_interval int(11) DEFAULT NULL,
  order_status varchar(50) DEFAULT NULL,
  on_hold tinyint(1) DEFAULT NULL,
  for_discard tinyint(1) DEFAULT NULL,
  discontinue_reason int(11) DEFAULT NULL,
  discontinuation_reasons varchar(255) DEFAULT NULL,
  last_dispatch_date datetime DEFAULT NULL,
  drug_expiry_date datetime DEFAULT NULL,
  comment_for_orderer varchar(255) DEFAULT NULL,
  comment_for_patient varchar(255) DEFAULT NULL,
  KEY order_id (order_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_drug_reference_map (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  drug_reference_map_id int(11) NOT NULL,
  drug_id int(11) NOT NULL,
  term_id int(11) NOT NULL,
  concept_map_type int(11) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY drug_for_drug_reference_map (drug_id),
  KEY concept_reference_term_for_drug_reference_map (term_id),
  KEY concept_map_type_for_drug_reference_map (concept_map_type),
  KEY user_who_changed_drug_reference_map (changed_by),
  KEY drug_reference_map_creator (creator),
  KEY user_who_retired_drug_reference_map (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_encounter (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  encounter_type int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT NULL,
  form_id int(11) DEFAULT NULL,
  encounter_datetime datetime NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  visit_id int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY encounter_id (encounter_id),
  KEY encounter_uuid_index (uuid),
  KEY encounter_datetime_idx (encounter_datetime),
  KEY encounter_ibfk_1 (creator),
  KEY encounter_type_id (encounter_type),
  KEY encounter_form (form_id),
  KEY encounter_location (location_id),
  KEY encounter_patient (patient_id),
  KEY user_who_voided_encounter (voided_by),
  KEY encounter_changed_by (changed_by),
  KEY encounter_visit_id_fk (visit_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_encounter_provider (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  encounter_provider_id int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  provider_id int(11) NOT NULL,
  encounter_role_id int(11) NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  date_voided datetime DEFAULT NULL,
  voided_by int(11) DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY uuid (uuid),
  KEY encounter_id_fk (encounter_id),
  KEY provider_id_fk (provider_id),
  KEY encounter_role_id_fk (encounter_role_id),
  KEY encounter_provider_creator (creator),
  KEY encounter_provider_changed_by (changed_by),
  KEY encounter_provider_voided_by (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_encounter_role (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  encounter_role_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY uuid (uuid),
  KEY encounter_role_unique_name (name),
  KEY encounter_role_creator_fk (creator),
  KEY encounter_role_changed_by_fk (changed_by),
  KEY encounter_role_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_encounter_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  encounter_type_id int(11) NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  description text,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  edit_privilege varchar(255) DEFAULT NULL,
  view_privilege varchar(255) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  KEY encounter_type_unique_name (name),
  KEY encounter_type_uuid_index (uuid),
  KEY encounter_type_retired_status (retired),
  KEY user_who_created_type (creator),
  KEY user_who_retired_encounter_type (retired_by),
  KEY privilege_which_can_view_encounter_type (view_privilege),
  KEY privilege_which_can_edit_encounter_type (edit_privilege)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_field (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  field_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  description text,
  field_type int(11) DEFAULT NULL,
  concept_id int(11) DEFAULT NULL,
  table_name varchar(50) DEFAULT NULL,
  attribute_name varchar(50) DEFAULT NULL,
  default_value text,
  select_multiple tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) DEFAULT NULL,
  KEY field_uuid_index (uuid),
  KEY field_retired_status (retired),
  KEY user_who_changed_field (changed_by),
  KEY concept_for_field (concept_id),
  KEY user_who_created_field (creator),
  KEY type_of_field (field_type),
  KEY user_who_retired_field (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_field_answer (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  field_id int(11) NOT NULL DEFAULT '0',
  answer_id int(11) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  uuid char(38) DEFAULT NULL,
  KEY field_answer_uuid_index (uuid),
  KEY field_answer_concept (answer_id),
  KEY user_who_created_field_answer (creator)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_field_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  field_type_id int(11) NOT NULL,
  name varchar(50) DEFAULT NULL,
  description text,
  is_set tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  uuid char(38) DEFAULT NULL,
  KEY field_type_uuid_index (uuid),
  KEY user_who_created_field_type (creator)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_form (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  form_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  version varchar(50) NOT NULL DEFAULT '',
  build int(11) DEFAULT NULL,
  published tinyint(1) NOT NULL DEFAULT '0',
  xslt text,
  template text,
  description text,
  encounter_type int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retired_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY form_uuid_index (uuid),
  KEY form_published_index (published),
  KEY form_retired_index (retired),
  KEY form_published_and_retired_index (published,retired),
  KEY user_who_last_changed_form (changed_by),
  KEY user_who_created_form (creator),
  KEY form_encounter_type (encounter_type),
  KEY user_who_retired_form (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_form_field (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  form_field_id int(11) NOT NULL,
  form_id int(11) NOT NULL DEFAULT '0',
  field_id int(11) NOT NULL DEFAULT '0',
  field_number int(11) DEFAULT NULL,
  field_part varchar(5) DEFAULT NULL,
  page_number int(11) DEFAULT NULL,
  parent_form_field int(11) DEFAULT NULL,
  min_occurs int(11) DEFAULT NULL,
  max_occurs int(11) DEFAULT NULL,
  required tinyint(1) NOT NULL DEFAULT '0',
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  sort_weight double DEFAULT NULL,
  uuid char(38) DEFAULT NULL,
  KEY form_field_uuid_index (uuid),
  KEY user_who_last_changed_form_field (changed_by),
  KEY user_who_created_form_field (creator),
  KEY field_within_form (field_id),
  KEY form_containing_field (form_id),
  KEY form_field_hierarchy (parent_form_field)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_element (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  element_id int(11) NOT NULL,
  element_name varchar(45) NOT NULL,
  validation_regex varchar(255) DEFAULT NULL,
  data_type varchar(10) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY element_name_UNIQUE (element_name),
  KEY fk_element_users1_idx (created_by),
  KEY fk_element_users2_idx (changed_by),
  KEY fk_element_location1_idx (created_at),
  KEY fk_element_location2_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_location (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  location_name varchar(45) NOT NULL,
  category varchar(20) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  address1 varchar(45) DEFAULT NULL,
  address2 varchar(45) DEFAULT NULL,
  address3 varchar(45) DEFAULT NULL,
  city_village varchar(45) DEFAULT NULL,
  state_province varchar(45) DEFAULT NULL,
  country varchar(45) DEFAULT NULL,
  landmark1 varchar(45) DEFAULT NULL,
  landmark2 varchar(45) DEFAULT NULL,
  latitude varchar(45) DEFAULT NULL,
  longitude varchar(45) DEFAULT NULL,
  primary_contact varchar(20) DEFAULT NULL,
  secondary_contact varchar(20) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  fax varchar(20) DEFAULT NULL,
  parent_location int(11) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY location_name_UNIQUE (location_name),
  KEY fk_location_location1_idx (parent_location),
  KEY fk_location_location2_idx (created_at),
  KEY fk_location_location3_idx (changed_at),
  KEY fk_location_users1_idx (created_by),
  KEY fk_location_users2_idx (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_location_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_attribute_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  attribute_value varchar(255) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  KEY fk_location_attribute_location_attribute_type1_idx (attribute_type_id),
  KEY fk_location_attribute_location1_idx (location_id),
  KEY fk_location_attribute_users1_idx (created_by),
  KEY fk_location_attribute_users2_idx (changed_by),
  KEY fk_location_attribute_location2_idx (created_at),
  KEY fk_location_attribute_location3_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_location_attribute_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_attribute_type_id int(11) NOT NULL,
  attribute_name varchar(45) NOT NULL,
  validation_regex varchar(255) DEFAULT NULL,
  required tinyint(4) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  data_type varchar(10) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY attribute_name_UNIQUE (attribute_name),
  KEY fk_location_attribute_type_users1_idx (created_by),
  KEY fk_location_attribute_type_users2_idx (changed_by),
  KEY fk_location_attribute_type_location1_idx (created_at),
  KEY fk_location_attribute_type_location2_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_user_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_attribute_id int(11) NOT NULL,
  attribute_value varchar(255) NOT NULL,
  date_changed datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  changed_at int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  user_attribute_type_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  changed_by int(11) DEFAULT NULL,
  created_by int(11) DEFAULT NULL,
  uuid varchar(38) NOT NULL,
  UNIQUE KEY user_attribute_id (user_attribute_id),
  UNIQUE KEY uuid (uuid),
  UNIQUE KEY uuid_2 (uuid),
  KEY fk_user_attribute_user1_idx (user_id),
  KEY fk_user_attribute_user2_idx (created_by),
  KEY fk_user_attribute_location1_idx (created_at),
  KEY fk_user_attribute_user3_idx (changed_by),
  KEY fk_user_attribute_location2_idx (changed_at),
  KEY fk_user_attribute_user_attribute_type_idx (user_attribute_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_user_attribute_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_attribute_type_id int(11) NOT NULL,
  attribute_name varchar(45) NOT NULL,
  data_type varchar(10) NOT NULL,
  date_changed datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  description varchar(255) DEFAULT NULL,
  required tinyint(4) NOT NULL,
  uuid varchar(38) NOT NULL,
  validation_regex varchar(255) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  created_by int(11) DEFAULT NULL,
  UNIQUE KEY user_attribute_type_id (user_attribute_type_id),
  UNIQUE KEY attribute_name (attribute_name),
  UNIQUE KEY uuid (uuid),
  UNIQUE KEY uuid_2 (uuid),
  KEY fk_user_attribute_type_user1_idx (created_by),
  KEY fk_user_attribute_type_location1_idx (created_at),
  KEY fk_user_attribute_type_user2_idx (changed_by),
  KEY fk_user_attribute_type_location2_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_user_form (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_form_id int(11) NOT NULL,
  user_form_type_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  duration_seconds int(11) DEFAULT NULL,
  date_entered datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_user_form_type1_idx (user_form_type_id),
  KEY fk_user_form_users1_idx (user_id),
  KEY fk_user_form_users2_idx (created_by),
  KEY fk_user_form_users3_idx (changed_by),
  KEY fk_user_form_location1_idx (created_at),
  KEY fk_user_form_location2_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_user_form_result (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_form_result_id int(11) NOT NULL,
  user_form_id int(11) NOT NULL,
  element_id int(11) NOT NULL,
  result varchar(5000) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_result_user_form1_idx (element_id),
  KEY fk_user_form_result_location1_idx (created_at),
  KEY fk_user_form_result_location2_idx (changed_at),
  KEY fk_user_form_result_users1_idx (created_by),
  KEY fk_user_form_result_users2_idx (changed_by),
  KEY fk_user_form_result_user_form_idx (user_form_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_user_form_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_form_type_id int(11) NOT NULL,
  user_form_type varchar(45) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  description varchar(255) DEFAULT NULL,
  UNIQUE KEY user_form_type_UNIQUE (user_form_type),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_type_location1_idx (created_at),
  KEY fk_user_form_type_location2_idx (changed_at),
  KEY fk_user_form_type_users1_idx (created_by),
  KEY fk_user_form_type_users1_idx1 (changed_by),
  KEY FKC9467A6187F9F544 (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_user_location (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_location_location1_idx (location_id),
  KEY fk_user_location_users1_idx (created_by),
  KEY fk_user_location_users3_idx (changed_by),
  KEY fk_user_location_location2_idx (created_at),
  KEY fk_user_location_location3_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_user_role (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  role_id int(11) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_role_role1_idx (role_id),
  KEY fk_user_role_users2_idx (created_by),
  KEY fk_user_role_users3_idx (changed_by),
  KEY fk_user_role_location1_idx (created_at),
  KEY fk_user_role_location2_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_gfatm_users (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  username varchar(20) NOT NULL,
  full_name varchar(255) DEFAULT NULL,
  global_data_access tinyint(4) DEFAULT NULL,
  disabled tinyint(4) DEFAULT NULL,
  reason_disabled varchar(255) DEFAULT NULL,
  password_hash varchar(512) DEFAULT NULL,
  password_salt varchar(512) DEFAULT NULL,
  secret_question varchar(255) DEFAULT NULL,
  secret_answer_hash varchar(512) DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  UNIQUE KEY uuidx (uuid),
  UNIQUE KEY username_UNIQUE (username),
  KEY fk_users_location_idx (created_at),
  KEY fk_users_location1_idx (changed_at),
  KEY fk_users_user1_idx (created_by),
  KEY fk_users_users2_idx (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_group_obs (
  implementation_id int(11) NOT NULL DEFAULT '0',
  encounter_type int(11) DEFAULT NULL,
  obs_group_id int(11) DEFAULT NULL,
  question varchar(255) CHARACTER SET utf8 DEFAULT '',
  answer text CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_location (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT '',
  description varchar(255) DEFAULT NULL,
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_village varchar(255) DEFAULT NULL,
  state_province varchar(255) DEFAULT NULL,
  postal_code varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL,
  latitude varchar(50) DEFAULT NULL,
  longitude varchar(50) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  county_district varchar(255) DEFAULT NULL,
  address3 varchar(255) DEFAULT NULL,
  address4 varchar(255) DEFAULT NULL,
  address5 varchar(255) DEFAULT NULL,
  address6 varchar(255) DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  parent_location int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  KEY location_uuid_index (uuid),
  KEY name_of_location (name),
  KEY location_retired_status (retired),
  KEY user_who_created_location (creator),
  KEY user_who_retired_location (retired_by),
  KEY parent_location (parent_location),
  KEY location_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_location_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_attribute_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference text NOT NULL,
  uuid char(38) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  KEY uuid (uuid),
  KEY location_attribute_location_fk (location_id),
  KEY location_attribute_attribute_type_id_fk (attribute_type_id),
  KEY location_attribute_creator_fk (creator),
  KEY location_attribute_changed_by_fk (changed_by),
  KEY location_attribute_voided_by_fk (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_location_attribute_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_attribute_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  datatype varchar(255) DEFAULT NULL,
  datatype_config text,
  preferred_handler varchar(255) DEFAULT NULL,
  handler_config text,
  min_occurs int(11) NOT NULL,
  max_occurs int(11) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY uuid (uuid),
  KEY location_attribute_type_unique_name (name),
  KEY location_attribute_type_creator_fk (creator),
  KEY location_attribute_type_changed_by_fk (changed_by),
  KEY location_attribute_type_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_location_tag (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_tag_id int(11) NOT NULL,
  name varchar(50) NOT NULL,
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  KEY location_tag_uuid_index (uuid),
  KEY location_tag_creator (creator),
  KEY location_tag_retired_by (retired_by),
  KEY location_tag_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_location_tag_map (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  location_id int(11) NOT NULL,
  location_tag_id int(11) NOT NULL,
  KEY location_tag_map_tag (location_tag_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_obs (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  obs_id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) DEFAULT NULL,
  order_id int(11) DEFAULT NULL,
  obs_datetime datetime NOT NULL,
  location_id int(11) DEFAULT NULL,
  obs_group_id int(11) DEFAULT NULL,
  accession_number varchar(255) DEFAULT NULL,
  value_group_id int(11) DEFAULT NULL,
  value_coded int(11) DEFAULT NULL,
  value_coded_name_id int(11) DEFAULT NULL,
  value_drug int(11) DEFAULT NULL,
  value_datetime datetime DEFAULT NULL,
  value_numeric double DEFAULT NULL,
  value_modifier varchar(2) DEFAULT NULL,
  value_text text,
  value_complex varchar(1000) DEFAULT NULL,
  comments varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  previous_version int(11) DEFAULT NULL,
  form_namespace_and_path varchar(255) DEFAULT NULL,
  status varchar(16) NOT NULL DEFAULT 'FINAL',
  interpretation varchar(32) DEFAULT NULL,
  KEY obs_uuid_index (uuid),
  KEY obs_datetime_idx (obs_datetime),
  KEY obs_concept (concept_id),
  KEY obs_enterer (creator),
  KEY encounter_observations (encounter_id),
  KEY obs_location (location_id),
  KEY obs_grouping_id (obs_group_id),
  KEY obs_order (order_id),
  KEY person_obs (person_id),
  KEY answer_concept (value_coded),
  KEY obs_name_of_coded_value (value_coded_name_id),
  KEY answer_concept_drug (value_drug),
  KEY user_who_voided_obs (voided_by),
  KEY previous_version (previous_version)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_obs_20180727_30 (
  surrogate_id int(11) NOT NULL DEFAULT '0',
  implementation_id int(11) NOT NULL,
  obs_id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  concept_id int(11) NOT NULL DEFAULT '0',
  encounter_id int(11) DEFAULT NULL,
  order_id int(11) DEFAULT NULL,
  obs_datetime datetime NOT NULL,
  location_id int(11) DEFAULT NULL,
  obs_group_id int(11) DEFAULT NULL,
  accession_number varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  value_group_id int(11) DEFAULT NULL,
  value_coded int(11) DEFAULT NULL,
  value_coded_name_id int(11) DEFAULT NULL,
  value_drug int(11) DEFAULT NULL,
  value_datetime datetime DEFAULT NULL,
  value_numeric double DEFAULT NULL,
  value_modifier varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  value_text text CHARACTER SET utf8,
  value_complex varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  comments varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  uuid char(38) CHARACTER SET utf8 NOT NULL,
  previous_version int(11) DEFAULT NULL,
  form_namespace_and_path varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  status varchar(16) CHARACTER SET utf8 NOT NULL DEFAULT 'FINAL',
  interpretation varchar(32) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS tmp_orders (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  order_id int(11) NOT NULL,
  order_type_id int(11) NOT NULL DEFAULT '0',
  concept_id int(11) NOT NULL DEFAULT '0',
  orderer int(11) NOT NULL,
  encounter_id int(11) NOT NULL,
  instructions text,
  date_activated datetime DEFAULT NULL,
  auto_expire_date datetime DEFAULT NULL,
  date_stopped datetime DEFAULT NULL,
  order_reason int(11) DEFAULT NULL,
  order_reason_non_coded varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  patient_id int(11) NOT NULL,
  accession_number varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  urgency varchar(50) NOT NULL DEFAULT 'ROUTINE',
  order_number varchar(50) NOT NULL,
  previous_order_id int(11) DEFAULT NULL,
  order_action varchar(50) NOT NULL,
  comment_to_fulfiller varchar(1024) DEFAULT NULL,
  care_setting int(11) NOT NULL,
  scheduled_date datetime DEFAULT NULL,
  order_group_id int(11) DEFAULT NULL,
  sort_weight double DEFAULT NULL,
  UNIQUE KEY orders_uuid_index (uuid),
  KEY order_creator (creator),
  KEY orders_in_encounter (encounter_id),
  KEY type_of_order (order_type_id),
  KEY order_for_patient (patient_id),
  KEY user_who_voided_order (voided_by),
  KEY previous_order_id_order_id (previous_order_id),
  KEY orders_care_setting (care_setting),
  KEY discontinued_because (order_reason),
  KEY fk_orderer_provider (orderer),
  KEY orders_order_group_id_fk (order_group_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_patient (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  patient_id int(11) NOT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  KEY user_who_changed_pat (changed_by),
  KEY user_who_created_patient (creator),
  KEY user_who_voided_patient (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_patient_identifier (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  patient_identifier_id int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  identifier varchar(50) NOT NULL DEFAULT '',
  identifier_type int(11) NOT NULL DEFAULT '0',
  preferred tinyint(1) NOT NULL DEFAULT '0',
  location_id int(11) DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY patient_identifier_uuid_index (uuid),
  KEY identifier_name (identifier),
  KEY idx_patient_identifier_patient (patient_id),
  KEY identifier_creator (creator),
  KEY defines_identifier_type (identifier_type),
  KEY patient_identifier_ibfk_2 (location_id),
  KEY identifier_voider (voided_by),
  KEY patient_identifier_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_patient_identifier_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  patient_identifier_type_id int(11) NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  description text,
  format varchar(255) DEFAULT NULL,
  check_digit tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  required tinyint(1) NOT NULL DEFAULT '0',
  format_description varchar(255) DEFAULT NULL,
  validator varchar(200) DEFAULT NULL,
  location_behavior varchar(50) DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  uniqueness_behavior varchar(50) DEFAULT NULL,
  KEY patient_identifier_type_uuid_index (uuid),
  KEY patient_identifier_type_retired_status (retired),
  KEY type_creator (creator),
  KEY user_who_retired_patient_identifier_type (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_patient_program (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  patient_program_id int(11) NOT NULL,
  patient_id int(11) NOT NULL DEFAULT '0',
  program_id int(11) NOT NULL DEFAULT '0',
  date_enrolled datetime DEFAULT NULL,
  date_completed datetime DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  outcome_concept_id int(11) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY patient_program_uuid_index (uuid),
  KEY user_who_changed (changed_by),
  KEY patient_program_creator (creator),
  KEY patient_in_program (patient_id),
  KEY program_for_patient (program_id),
  KEY user_who_voided_patient_program (voided_by),
  KEY patient_program_location_id (location_id),
  KEY patient_program_outcome_concept_id_fk (outcome_concept_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_person (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  gender varchar(50) DEFAULT '',
  birthdate date DEFAULT NULL,
  birthdate_estimated tinyint(1) NOT NULL DEFAULT '0',
  dead tinyint(1) NOT NULL DEFAULT '0',
  death_date datetime DEFAULT NULL,
  cause_of_death int(11) DEFAULT NULL,
  creator int(11) DEFAULT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  deathdate_estimated tinyint(1) NOT NULL DEFAULT '0',
  birthtime time DEFAULT NULL,
  KEY person_id (person_id),
  KEY person_uuid_index (uuid),
  KEY person_birthdate (birthdate),
  KEY person_death_date (death_date),
  KEY person_died_because (cause_of_death),
  KEY user_who_changed_person (changed_by),
  KEY user_who_created_person (creator),
  KEY user_who_voided_person (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_person_address (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  person_address_id int(11) NOT NULL,
  person_id int(11) DEFAULT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_village varchar(255) DEFAULT NULL,
  state_province varchar(255) DEFAULT NULL,
  postal_code varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL,
  latitude varchar(50) DEFAULT NULL,
  longitude varchar(50) DEFAULT NULL,
  start_date datetime DEFAULT NULL,
  end_date datetime DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  county_district varchar(255) DEFAULT NULL,
  address3 varchar(255) DEFAULT NULL,
  address4 varchar(255) DEFAULT NULL,
  address5 varchar(255) DEFAULT NULL,
  address6 varchar(255) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY person_address_uuid_index (uuid),
  KEY patient_address_creator (creator),
  KEY address_for_person (person_id),
  KEY patient_address_void (voided_by),
  KEY person_address_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_person_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  person_attribute_id int(11) NOT NULL,
  person_id int(11) NOT NULL DEFAULT '0',
  value varchar(50) NOT NULL DEFAULT '',
  person_attribute_type_id int(11) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY person_attribute_uuid_index (uuid),
  KEY attribute_changer (changed_by),
  KEY attribute_creator (creator),
  KEY defines_attribute_type (person_attribute_type_id),
  KEY identifies_person (person_id),
  KEY attribute_voider (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_person_attribute_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  person_attribute_type_id int(11) NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  description text,
  format varchar(50) DEFAULT NULL,
  foreign_key int(11) DEFAULT NULL,
  searchable tinyint(1) NOT NULL DEFAULT '0',
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  edit_privilege varchar(255) DEFAULT NULL,
  sort_weight double DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY person_attribute_type_uuid_index (uuid),
  KEY attribute_is_searchable (searchable),
  KEY name_of_attribute (name),
  KEY person_attribute_type_retired_status (retired),
  KEY attribute_type_changer (changed_by),
  KEY attribute_type_creator (creator),
  KEY user_who_retired_person_attribute_type (retired_by),
  KEY privilege_which_can_edit (edit_privilege)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_person_name (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  person_name_id int(11) NOT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  person_id int(11) NOT NULL,
  prefix varchar(50) DEFAULT NULL,
  given_name varchar(50) DEFAULT NULL,
  middle_name varchar(50) DEFAULT NULL,
  family_name_prefix varchar(50) DEFAULT NULL,
  family_name varchar(50) DEFAULT NULL,
  family_name2 varchar(50) DEFAULT NULL,
  family_name_suffix varchar(50) DEFAULT NULL,
  degree varchar(50) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY person_name_uuid_index (uuid),
  KEY first_name (given_name),
  KEY last_name (family_name),
  KEY middle_name (middle_name),
  KEY family_name2 (family_name2),
  KEY user_who_made_name (creator),
  KEY name_for_person (person_id),
  KEY user_who_voided_name (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_privilege (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  privilege varchar(255) NOT NULL,
  description text,
  uuid char(38) NOT NULL,
  KEY privilege_uuid_index (uuid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_provider (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  provider_id int(11) NOT NULL,
  person_id int(11) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  identifier varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY uuid (uuid),
  KEY provider_changed_by_fk (changed_by),
  KEY provider_person_id_fk (person_id),
  KEY provider_retired_by_fk (retired_by),
  KEY provider_creator_fk (creator)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_provider_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  provider_attribute_id int(11) NOT NULL,
  provider_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference text NOT NULL,
  uuid char(38) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  KEY uuid (uuid),
  KEY provider_attribute_provider_fk (provider_id),
  KEY provider_attribute_attribute_type_id_fk (attribute_type_id),
  KEY provider_attribute_creator_fk (creator),
  KEY provider_attribute_changed_by_fk (changed_by),
  KEY provider_attribute_voided_by_fk (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_provider_attribute_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  provider_attribute_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  datatype varchar(255) DEFAULT NULL,
  datatype_config text,
  preferred_handler varchar(255) DEFAULT NULL,
  handler_config text,
  min_occurs int(11) NOT NULL,
  max_occurs int(11) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY uuid (uuid),
  KEY provider_attribute_type_creator_fk (creator),
  KEY provider_attribute_type_changed_by_fk (changed_by),
  KEY provider_attribute_type_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_relationship (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  relationship_id int(11) NOT NULL,
  person_a int(11) NOT NULL,
  relationship int(11) NOT NULL DEFAULT '0',
  person_b int(11) NOT NULL,
  start_date datetime DEFAULT NULL,
  end_date datetime DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY relation_creator (creator),
  KEY person_a_is_person (person_a),
  KEY person_b_is_person (person_b),
  KEY relationship_type_id (relationship),
  KEY relation_voider (voided_by),
  KEY relationship_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_relationship_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  relationship_type_id int(11) NOT NULL,
  a_is_to_b varchar(50) NOT NULL,
  b_is_to_a varchar(50) NOT NULL,
  preferred tinyint(1) NOT NULL DEFAULT '0',
  weight int(11) NOT NULL DEFAULT '0',
  description varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  KEY user_who_created_rel (creator),
  KEY user_who_retired_relationship_type (retired_by),
  KEY relationship_type_changed_by (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_role (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  role varchar(50) NOT NULL DEFAULT '',
  description varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY role_uuid_index (uuid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_role_privilege (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  role varchar(50) NOT NULL DEFAULT '',
  privilege varchar(255) NOT NULL,
  KEY role_privilege_to_role (role)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_role_role (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  parent_role varchar(50) NOT NULL DEFAULT '',
  child_role varchar(50) NOT NULL DEFAULT '',
  KEY inherited_role (child_role)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_user_property (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  property varchar(100) NOT NULL DEFAULT '',
  property_value varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_user_role (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  role varchar(50) NOT NULL DEFAULT '',
  KEY user_role_to_users (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_users (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  system_id varchar(50) NOT NULL DEFAULT '',
  username varchar(50) DEFAULT NULL,
  password varchar(128) DEFAULT NULL,
  salt varchar(128) DEFAULT NULL,
  secret_question varchar(255) DEFAULT NULL,
  secret_answer varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  person_id int(11) NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY user_who_changed_user (changed_by),
  KEY user_creator (creator),
  KEY user_who_retired_this_user (retired_by),
  KEY person_id_for_user (person_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_visit_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  visit_attribute_id int(11) NOT NULL,
  visit_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference text NOT NULL,
  uuid char(38) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  KEY uuid (uuid),
  KEY visit_attribute_visit_fk (visit_id),
  KEY visit_attribute_attribute_type_id_fk (attribute_type_id),
  KEY visit_attribute_creator_fk (creator),
  KEY visit_attribute_changed_by_fk (changed_by),
  KEY visit_attribute_voided_by_fk (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_visit_attribute_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  visit_attribute_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  datatype varchar(255) DEFAULT NULL,
  datatype_config text,
  preferred_handler varchar(255) DEFAULT NULL,
  handler_config text,
  min_occurs int(11) NOT NULL,
  max_occurs int(11) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY uuid (uuid),
  KEY visit_attribute_type_creator_fk (creator),
  KEY visit_attribute_type_changed_by_fk (changed_by),
  KEY visit_attribute_type_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tmp_visit_type (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  visit_type_id int(11) NOT NULL DEFAULT '0',
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  KEY uuid (uuid),
  KEY visit_type_creator (creator),
  KEY visit_type_changed_by (changed_by),
  KEY visit_type_retired_by (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS uform_fast_screening (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  user_form_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  username varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  location_name varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  date_entered datetime NOT NULL,
  endtime text CHARACTER SET utf8,
  two_weeks_cough text CHARACTER SET utf8,
  hospital_section text CHARACTER SET utf8,
  screening_location text CHARACTER SET utf8,
  opd_ward_section text CHARACTER SET utf8,
  patient_or_attendant text CHARACTER SET utf8,
  tuberculosis_contact text CHARACTER SET utf8,
  hospital_section_other text CHARACTER SET utf8,
  gender text CHARACTER SET utf8,
  age_range text CHARACTER SET utf8,
  history_of_tuberculosis text CHARACTER SET utf8,
  hospital_facility_name text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS uform_gfatm_feedback (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  user_form_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  username varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  location_name varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  date_entered datetime NOT NULL,
  endtime text CHARACTER SET utf8,
  feedback text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS uform_uvgi_baseline_meter_reading (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  user_form_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  username varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  location_name varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  date_entered datetime NOT NULL,
  average_reading_6ft text CHARACTER SET utf8,
  uv_reading_6ft_1m text CHARACTER SET utf8,
  uv_reading_6ft_2m text CHARACTER SET utf8,
  endtime text CHARACTER SET utf8,
  id text CHARACTER SET utf8,
  starttime text CHARACTER SET utf8,
  uv_reading_8ft_2m text CHARACTER SET utf8,
  uv_reading_8ft_0m text CHARACTER SET utf8,
  average_reading_8ft text CHARACTER SET utf8,
  uv_reading_8ft_1m text CHARACTER SET utf8,
  uv_reading_6ft_3m text CHARACTER SET utf8,
  uv_reading_8ft_3m text CHARACTER SET utf8,
  uv_reading_6ft_0m text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS uform_uvgi_installation (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  user_form_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  username varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  location_name varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  date_entered datetime NOT NULL,
  endtime text CHARACTER SET utf8,
  starttime text CHARACTER SET utf8,
  szc_area text CHARACTER SET utf8,
  location_type text CHARACTER SET utf8,
  uvgi_install_location text CHARACTER SET utf8,
  average_reading_8ft text CHARACTER SET utf8,
  uvgi_installed text CHARACTER SET utf8,
  average_reading_6ft text CHARACTER SET utf8,
  uv_reading_6ft_1m text CHARACTER SET utf8,
  uv_reading_6ft_2m text CHARACTER SET utf8,
  uv_reading_6ft_3m text CHARACTER SET utf8,
  id text CHARACTER SET utf8,
  uv_reading_8ft_2m text CHARACTER SET utf8,
  uv_reading_8ft_3m text CHARACTER SET utf8,
  uv_reading_8ft_1m text CHARACTER SET utf8,
  uv_reading_8ft_0m text CHARACTER SET utf8,
  uv_reading_6ft_0m text CHARACTER SET utf8,
  reason_uvgi_not_installed text CHARACTER SET utf8,
  opd text CHARACTER SET utf8,
  opd_area text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS uform_uvgi_maintenance (
  surrogate_id bigint(21) NOT NULL,
  implementation_id int(11) NOT NULL DEFAULT '0',
  user_form_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  username varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  location_name varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  date_entered datetime NOT NULL,
  maintainer_name text CHARACTER SET utf8,
  average_reading_before_cleaning_8ft text CHARACTER SET utf8,
  average_reading_before_cleaning_6ft text CHARACTER SET utf8,
  starttime text CHARACTER SET utf8,
  uv_reading_8ft_2m text CHARACTER SET utf8,
  uv_reading_8ft_0m text CHARACTER SET utf8,
  lamps_reinstalled text CHARACTER SET utf8,
  interior_cleaned text CHARACTER SET utf8,
  uv_reading_before_cleaning_8ft_1m text CHARACTER SET utf8,
  uv_reading_6ft_0m text CHARACTER SET utf8,
  uv_reading_before_cleaning_6ft_2m text CHARACTER SET utf8,
  uv_reading_6ft_2m text CHARACTER SET utf8,
  uv_reading_before_cleaning_6ft_0m text CHARACTER SET utf8,
  id text CHARACTER SET utf8,
  lamps_cleaned text CHARACTER SET utf8,
  parts_replaced_name text CHARACTER SET utf8,
  uv_part_replaced text CHARACTER SET utf8,
  lamps_removed text CHARACTER SET utf8,
  average_reading_6ft text CHARACTER SET utf8,
  louver_closed text CHARACTER SET utf8,
  maintainer_contact text CHARACTER SET utf8,
  uv_light_working text CHARACTER SET utf8,
  endtime text CHARACTER SET utf8,
  uv_reading_8ft_1m text CHARACTER SET utf8,
  power_connected text CHARACTER SET utf8,
  uv_reading_before_cleaning_8ft_0m text CHARACTER SET utf8,
  uv_reading_before_cleaning_8ft_2m text CHARACTER SET utf8,
  uv_reading_6ft_1m text CHARACTER SET utf8,
  uv_reading_before_cleaning_6ft_1m text CHARACTER SET utf8,
  louver_opened text CHARACTER SET utf8,
  average_reading_8ft text CHARACTER SET utf8,
  power_disconnected text CHARACTER SET utf8,
  average_reading_before_cleaning_9ft text CHARACTER SET utf8,
  uv_reading_before_cleaning_9ft_0m text CHARACTER SET utf8,
  uv_reading_9ft_0m text CHARACTER SET utf8,
  uv_reading_9ft_2m text CHARACTER SET utf8,
  uv_reading_before_cleaning_9ft_2m text CHARACTER SET utf8,
  uv_reading_9ft_1m text CHARACTER SET utf8,
  average_reading_9ft text CHARACTER SET utf8,
  uv_reading_before_cleaning_9ft_1m text CHARACTER SET utf8,
  average_reading_before_cleaning_10ft text CHARACTER SET utf8,
  uv_reading_before_cleaning_10ft_1m text CHARACTER SET utf8,
  uv_reading_10ft_1m text CHARACTER SET utf8,
  average_reading_10ft text CHARACTER SET utf8,
  uv_reading_before_cleaning_10ft_2m text CHARACTER SET utf8,
  uv_reading_10ft_0m text CHARACTER SET utf8,
  uv_reading_before_cleaning_10ft_0m text CHARACTER SET utf8,
  uv_reading_10ft_2m text CHARACTER SET utf8,
  uv_reading_before_cleaning_6ft_3m text CHARACTER SET utf8,
  BLANK char(0) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS user_attribute (
  surrogate_id int(11) NOT NULL,
  implementation_id int(11) NOT NULL,
  user_attribute_id int(11) NOT NULL,
  attribute_value varchar(255) NOT NULL,
  date_changed datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  changed_at int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  user_attribute_type_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  changed_by int(11) DEFAULT NULL,
  created_by int(11) DEFAULT NULL,
  uuid varchar(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY user_attribute_id (user_attribute_id),
  UNIQUE KEY uuid (uuid),
  UNIQUE KEY uuid_2 (uuid),
  KEY fk_user_attribute_user1_idx (user_id),
  KEY fk_user_attribute_user2_idx (created_by),
  KEY fk_user_attribute_gfatm_location1_idx (created_at),
  KEY fk_user_attribute_user3_idx (changed_by),
  KEY fk_user_attribute_gfatm_location2_idx (changed_at),
  KEY fk_user_attribute_user_attribute_type_idx (user_attribute_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_attribute_type_id int(11) NOT NULL,
  attribute_name varchar(45) NOT NULL,
  data_type varchar(10) NOT NULL,
  date_changed datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  description varchar(255) DEFAULT NULL,
  required bit(1) NOT NULL,
  uuid varchar(38) NOT NULL,
  validation_regex varchar(255) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  created_by int(11) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY user_attribute_type_id (user_attribute_type_id),
  UNIQUE KEY attribute_name (attribute_name),
  UNIQUE KEY uuid (uuid),
  UNIQUE KEY uuid_2 (uuid),
  KEY fk_user_attribute_type_user1_idx (created_by),
  KEY fk_user_attribute_type_gfatm_location1_idx (created_at),
  KEY fk_user_attribute_type_user2_idx (changed_by),
  KEY fk_user_attribute_type_gfatm_location2_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_form (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_form_id int(11) NOT NULL,
  user_form_type_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  duration_seconds int(11) DEFAULT NULL,
  date_entered datetime DEFAULT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_user_form_type1_idx (user_form_type_id),
  KEY fk_user_form_users1_idx (user_id),
  KEY fk_user_form_users2_idx (created_by),
  KEY fk_user_form_users3_idx (changed_by),
  KEY fk_user_form_gfatm_location1_idx (created_at),
  KEY fk_user_form_gfatm_location2_idx (changed_at),
  KEY fk_user_form_gfatm_user_form_idx (user_form_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_form_result (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_form_result_id int(11) NOT NULL,
  user_form_id int(11) NOT NULL,
  element_id int(11) NOT NULL,
  result varchar(255) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_result_user_form1_idx (element_id),
  KEY fk_user_form_result_gfatm_location1_idx (created_at),
  KEY fk_user_form_result_gfatm_location2_idx (changed_at),
  KEY fk_user_form_result_users1_idx (created_by),
  KEY fk_user_form_result_users2_idx (changed_by),
  KEY fk_user_form_result_user_form_idx (user_form_id),
  KEY fk_user_form_result_user_form_result_id (user_form_result_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_form_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_form_type_id int(11) NOT NULL,
  user_form_type varchar(45) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  description varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY user_form_type_UNIQUE (user_form_type),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_form_type_gfatm_location1_idx (created_at),
  KEY fk_user_form_type_gfatm_location2_idx (changed_at),
  KEY fk_user_form_type_users1_idx (created_by),
  KEY fk_user_form_type_users1_idx1 (changed_by),
  KEY FKC9467A6187F9F544 (changed_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_gfatm_location (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  gfatm_location_id int(11) NOT NULL,
  date_created datetime NOT NULL,
  created_by int(11) DEFAULT NULL,
  created_at int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  changed_by int(11) DEFAULT NULL,
  changed_at int(11) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  UNIQUE KEY uuidx (uuid),
  KEY fk_user_gfatm_location_gfatm_location1_idx (gfatm_location_id),
  KEY fk_user_gfatm_location_users1_idx (created_by),
  KEY fk_user_gfatm_location_users3_idx (changed_by),
  KEY fk_user_gfatm_location_gfatm_location2_idx (created_at),
  KEY fk_user_gfatm_location_gfatm_location3_idx (changed_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_property (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  property varchar(100) NOT NULL DEFAULT '',
  property_value varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_role (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  role varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (surrogate_id),
  KEY user_role_to_users (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS user_role_merged (
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL DEFAULT '0',
  anonymous text CHARACTER SET utf8,
  authenticated text CHARACTER SET utf8,
  call_center_agent text CHARACTER SET utf8,
  childhoodtb_lab_technician text CHARACTER SET utf8,
  childhoodtb_medical_officer text CHARACTER SET utf8,
  childhoodtb_monitor text CHARACTER SET utf8,
  childhoodtb_nurse text CHARACTER SET utf8,
  childhoodtb_program_assistant text CHARACTER SET utf8,
  childhoodtb_program_manager text CHARACTER SET utf8,
  clinical_coordinator text CHARACTER SET utf8,
  clinician text CHARACTER SET utf8,
  community_health_services text CHARACTER SET utf8,
  comorbidities_associate_diabetologist text CHARACTER SET utf8,
  comorbidities_counselor text CHARACTER SET utf8,
  comorbidities_diabetes_educator text CHARACTER SET utf8,
  comorbidities_eye_screener text CHARACTER SET utf8,
  comorbidities_foot_screener text CHARACTER SET utf8,
  comorbidities_health_worker text CHARACTER SET utf8,
  comorbidities_program_manager text CHARACTER SET utf8,
  comorbidities_psychologist text CHARACTER SET utf8,
  counselor text CHARACTER SET utf8,
  data_entry_operator text CHARACTER SET utf8,
  diabetes_educator text CHARACTER SET utf8,
  facility_dot_provider text CHARACTER SET utf8,
  fast_facilitator text CHARACTER SET utf8,
  fast_field_supervisor text CHARACTER SET utf8,
  fast_lab_technician text CHARACTER SET utf8,
  fast_manager text CHARACTER SET utf8,
  fast_program_manager text CHARACTER SET utf8,
  fast_screener text CHARACTER SET utf8,
  fast_site_manager text CHARACTER SET utf8,
  field_supervisor text CHARACTER SET utf8,
  health_worker text CHARACTER SET utf8,
  implementer text CHARACTER SET utf8,
  lab_technician text CHARACTER SET utf8,
  medical_officer text CHARACTER SET utf8,
  monitor text CHARACTER SET utf8,
  pet_clinician text CHARACTER SET utf8,
  pet_field_supervisor text CHARACTER SET utf8,
  pet_health_worker text CHARACTER SET utf8,
  pet_program_manager text CHARACTER SET utf8,
  pet_psychologist text CHARACTER SET utf8,
  pmdt_diabetes_educator text CHARACTER SET utf8,
  pmdt_lab_technician text CHARACTER SET utf8,
  pmdt_program_manager text CHARACTER SET utf8,
  pmdt_treatment_coordinator text CHARACTER SET utf8,
  pmdt_treatment_supporter text CHARACTER SET utf8,
  program_manager text CHARACTER SET utf8,
  provider text CHARACTER SET utf8,
  psychologist text CHARACTER SET utf8,
  referral_site_coordinator text CHARACTER SET utf8,
  screener text CHARACTER SET utf8,
  system_developer text CHARACTER SET utf8,
  treatment_coordinator text CHARACTER SET utf8,
  treatment_supporter text CHARACTER SET utf8,
  BLANK char(0) CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (implementation_id,user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS users (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  system_id varchar(50) NOT NULL DEFAULT '',
  username varchar(50) DEFAULT NULL,
  password varchar(128) DEFAULT NULL,
  salt varchar(128) DEFAULT NULL,
  secret_question varchar(255) DEFAULT NULL,
  secret_answer varchar(255) DEFAULT NULL,
  creator int(11) NOT NULL DEFAULT '0',
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  person_id int(11) NOT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY user_who_changed_user (changed_by),
  KEY user_creator (creator),
  KEY user_who_retired_this_user (retired_by),
  KEY person_id_for_user (person_id),
  KEY user_id (user_id),
  KEY system_id (system_id),
  KEY username (username)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS visit (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  visit_id int(11) NOT NULL,
  patient_id int(11) NOT NULL,
  visit_type_id int(11) NOT NULL,
  date_started datetime NOT NULL,
  date_stopped datetime DEFAULT NULL,
  indication_concept_id int(11) DEFAULT NULL,
  location_id int(11) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY visit_patient_index (patient_id),
  KEY visit_type_fk (visit_type_id),
  KEY visit_location_fk (location_id),
  KEY visit_creator_fk (creator),
  KEY visit_voided_by_fk (voided_by),
  KEY visit_changed_by_fk (changed_by),
  KEY visit_indication_concept_fk (indication_concept_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS visit_attribute (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  visit_attribute_id int(11) NOT NULL,
  visit_id int(11) NOT NULL,
  attribute_type_id int(11) NOT NULL,
  value_reference text NOT NULL,
  uuid char(38) NOT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  voided tinyint(1) NOT NULL DEFAULT '0',
  voided_by int(11) DEFAULT NULL,
  date_voided datetime DEFAULT NULL,
  void_reason varchar(255) DEFAULT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY visit_attribute_visit_fk (visit_id),
  KEY visit_attribute_attribute_type_id_fk (attribute_type_id),
  KEY visit_attribute_creator_fk (creator),
  KEY visit_attribute_changed_by_fk (changed_by),
  KEY visit_attribute_voided_by_fk (voided_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS visit_attribute_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  visit_attribute_type_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  datatype varchar(255) DEFAULT NULL,
  datatype_config text,
  preferred_handler varchar(255) DEFAULT NULL,
  handler_config text,
  min_occurs int(11) NOT NULL,
  max_occurs int(11) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY visit_attribute_type_creator_fk (creator),
  KEY visit_attribute_type_changed_by_fk (changed_by),
  KEY visit_attribute_type_retired_by_fk (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS visit_type (
  surrogate_id int(11) NOT NULL AUTO_INCREMENT,
  implementation_id int(11) NOT NULL,
  visit_type_id int(11) NOT NULL DEFAULT '0',
  name varchar(255) NOT NULL,
  description varchar(1024) DEFAULT NULL,
  creator int(11) NOT NULL,
  date_created datetime NOT NULL,
  changed_by int(11) DEFAULT NULL,
  date_changed datetime DEFAULT NULL,
  retired tinyint(1) NOT NULL DEFAULT '0',
  retired_by int(11) DEFAULT NULL,
  date_retired datetime DEFAULT NULL,
  retire_reason varchar(255) DEFAULT NULL,
  uuid char(38) NOT NULL,
  PRIMARY KEY (surrogate_id),
  KEY uuid (uuid),
  KEY visit_type_creator (creator),
  KEY visit_type_changed_by (changed_by),
  KEY visit_type_retired_by (retired_by)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ------------------------
-- CREATE STORED PROCEDURES
-- ------------------------

	DROP TABLE IF EXISTS user_role_merged;

	CREATE TABLE IF NOT EXISTS user_role_merged SELECT a.implementation_id,
    a.user_id,
    GROUP_CONCAT(IF(a.role = 'Anonymous', 'Yes', NULL)) AS anonymous,
    GROUP_CONCAT(IF(a.role = 'Authenticated',
            'Yes',
            NULL)) AS authenticated,
    GROUP_CONCAT(IF(a.role = 'Call Center Agent',
            'Yes',
            NULL)) AS call_center_agent,
    GROUP_CONCAT(IF(a.role = 'ChildhoodTB Lab Technician',
            'Yes',
            NULL)) AS childhoodtb_lab_technician,
    GROUP_CONCAT(IF(a.role = 'ChildhoodTB Medical Officer',
            'Yes',
            NULL)) AS childhoodtb_medical_officer,
    GROUP_CONCAT(IF(a.role = 'ChildhoodTB Monitor',
            'Yes',
            NULL)) AS childhoodtb_monitor,
    GROUP_CONCAT(IF(a.role = 'ChildhoodTB Nurse',
            'Yes',
            NULL)) AS childhoodtb_nurse,
    GROUP_CONCAT(IF(a.role = 'ChildhoodTB Program Assistant',
            'Yes',
            NULL)) AS childhoodtb_program_assistant,
    GROUP_CONCAT(IF(a.role = 'ChildhoodTB Program Manager',
            'Yes',
            NULL)) AS childhoodtb_program_manager,
    GROUP_CONCAT(IF(a.role = 'Clinical Coordinator',
            'Yes',
            NULL)) AS clinical_coordinator,
    GROUP_CONCAT(IF(a.role = 'Clinician', 'Yes', NULL)) AS clinician,
    GROUP_CONCAT(IF(a.role = 'Community Health Services',
            'Yes',
            NULL)) AS community_health_services,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Associate Diabetologist',
            'Yes',
            NULL)) AS comorbidities_associate_diabetologist,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Counselor',
            'Yes',
            NULL)) AS comorbidities_counselor,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Diabetes Educator',
            'Yes',
            NULL)) AS comorbidities_diabetes_educator,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Eye Screener',
            'Yes',
            NULL)) AS comorbidities_eye_screener,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Foot Screener',
            'Yes',
            NULL)) AS comorbidities_foot_screener,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Health Worker',
            'Yes',
            NULL)) AS comorbidities_health_worker,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Program Manager',
            'Yes',
            NULL)) AS comorbidities_program_manager,
    GROUP_CONCAT(IF(a.role = 'Comorbidities Psychologist',
            'Yes',
            NULL)) AS comorbidities_psychologist,
    GROUP_CONCAT(IF(a.role = 'Counselor', 'Yes', NULL)) AS counselor,
    GROUP_CONCAT(IF(a.role = 'Data Entry Operator',
            'Yes',
            NULL)) AS data_entry_operator,
    GROUP_CONCAT(IF(a.role = 'Diabetes Educator',
            'Yes',
            NULL)) AS diabetes_educator,
    GROUP_CONCAT(IF(a.role = 'Facility DOT Provider',
            'Yes',
            NULL)) AS facility_dot_provider,
    GROUP_CONCAT(IF(a.role = 'FAST Facilitator',
            'Yes',
            NULL)) AS fast_facilitator,
    GROUP_CONCAT(IF(a.role = 'FAST Field Supervisor',
            'Yes',
            NULL)) AS fast_field_supervisor,
    GROUP_CONCAT(IF(a.role = 'FAST Lab Technician',
            'Yes',
            NULL)) AS fast_lab_technician,
    GROUP_CONCAT(IF(a.role = 'FAST Manager', 'Yes', NULL)) AS fast_manager,
    GROUP_CONCAT(IF(a.role = 'FAST Program Manager',
            'Yes',
            NULL)) AS fast_program_manager,
    GROUP_CONCAT(IF(a.role = 'FAST Screener',
            'Yes',
            NULL)) AS fast_screener,
    GROUP_CONCAT(IF(a.role = 'FAST Site Manager',
            'Yes',
            NULL)) AS fast_site_manager,
    GROUP_CONCAT(IF(a.role = 'Field Supervisor',
            'Yes',
            NULL)) AS field_supervisor,
    GROUP_CONCAT(IF(a.role = 'Health Worker',
            'Yes',
            NULL)) AS health_worker,
    GROUP_CONCAT(IF(a.role = 'Implementer', 'Yes', NULL)) AS implementer,
    GROUP_CONCAT(IF(a.role = 'Lab Technician',
            'Yes',
            NULL)) AS lab_technician,
    GROUP_CONCAT(IF(a.role = 'Medical Officer',
            'Yes',
            NULL)) AS medical_officer,
    GROUP_CONCAT(IF(a.role = 'Monitor', 'Yes', NULL)) AS monitor,
    GROUP_CONCAT(IF(a.role = 'PET Clinician',
            'Yes',
            NULL)) AS pet_clinician,
    GROUP_CONCAT(IF(a.role = 'PET Field Supervisor',
            'Yes',
            NULL)) AS pet_field_supervisor,
    GROUP_CONCAT(IF(a.role = 'PET Health Worker',
            'Yes',
            NULL)) AS pet_health_worker,
    GROUP_CONCAT(IF(a.role = 'PET Program Manager',
            'Yes',
            NULL)) AS pet_program_manager,
    GROUP_CONCAT(IF(a.role = 'PET Psychologist',
            'Yes',
            NULL)) AS pet_psychologist,
    GROUP_CONCAT(IF(a.role = 'PMDT Diabetes Educator',
            'Yes',
            NULL)) AS pmdt_diabetes_educator,
    GROUP_CONCAT(IF(a.role = 'PMDT Lab Technician',
            'Yes',
            NULL)) AS pmdt_lab_technician,
    GROUP_CONCAT(IF(a.role = 'PMDT Program Manager',
            'Yes',
            NULL)) AS pmdt_program_manager,
    GROUP_CONCAT(IF(a.role = 'PMDT Treatment Coordinator',
            'Yes',
            NULL)) AS pmdt_treatment_coordinator,
    GROUP_CONCAT(IF(a.role = 'PMDT Treatment Supporter',
            'Yes',
            NULL)) AS pmdt_treatment_supporter,
    GROUP_CONCAT(IF(a.role = 'Program Manager',
            'Yes',
            NULL)) AS program_manager,
    GROUP_CONCAT(IF(a.role = 'Provider', 'Yes', NULL)) AS provider,
    GROUP_CONCAT(IF(a.role = 'Psychologist', 'Yes', NULL)) AS psychologist,
    GROUP_CONCAT(IF(a.role = 'Referral Site Coordinator',
            'Yes',
            NULL)) AS referral_site_coordinator,
    GROUP_CONCAT(IF(a.role = 'Screener', 'Yes', NULL)) AS screener,
    GROUP_CONCAT(IF(a.role = 'System Developer',
            'Yes',
            NULL)) AS system_developer,
    GROUP_CONCAT(IF(a.role = 'Treatment Coordinator',
            'Yes',
            NULL)) AS treatment_coordinator,
    GROUP_CONCAT(IF(a.role = 'Treatment Supporter',
            'Yes',
            NULL)) AS treatment_supporter,
    '' AS BLANK FROM
    user_role AS a
WHERE
    a.implementation_id = impl_id
GROUP BY a.user_id;

	ALTER TABLE user_role_merged ADD PRIMARY KEY (implementation_id, user_id);

	TRUNCATE dim_user;

	INSERT INTO dim_user (surrogate_id, implementation_id, user_id, username, person_id, identifier, secret_question, secret_answer, creator, date_created, changed_by, date_changed, retired, retire_reason, uuid, anonymous,authenticated,call_center_agent,childhoodtb_lab_technician,childhoodtb_medical_officer,childhoodtb_monitor,childhoodtb_nurse,childhoodtb_program_assistant,childhoodtb_program_manager,clinical_coordinator,clinician,community_health_services,comorbidities_associate_diabetologist,comorbidities_counselor,comorbidities_diabetes_educator,comorbidities_eye_screener,comorbidities_foot_screener,comorbidities_health_worker,comorbidities_program_manager,comorbidities_psychologist,counselor,data_entry_operator,diabetes_educator,facility_dot_provider,fast_facilitator,fast_field_supervisor,fast_lab_technician,fast_manager,fast_program_manager,fast_screener,fast_site_manager,field_supervisor,health_worker,implementer,lab_technician,medical_officer,monitor,pet_clinician,pet_field_supervisor,pet_health_worker,pet_program_manager,pet_psychologist,pmdt_diabetes_educator,pmdt_lab_technician,pmdt_program_manager,pmdt_treatment_coordinator,pmdt_treatment_supporter,program_manager,provider,psychologist,referral_site_coordinator,screener,system_developer,treatment_coordinator,treatment_supporter) 
	SELECT u.surrogate_id, u.implementation_id, u.user_id, ifnull(u.username, '') AS username, u.person_id, p.identifier, u.secret_question, pa1.value_reference AS intervention, u.creator, u.date_created, u.changed_by, u.date_changed, u.retired, u.retire_reason, u.uuid, urm.anonymous,urm.authenticated,urm.call_center_agent,urm.childhoodtb_lab_technician,urm.childhoodtb_medical_officer,urm.childhoodtb_monitor,urm.childhoodtb_nurse,urm.childhoodtb_program_assistant,urm.childhoodtb_program_manager,urm.clinical_coordinator,urm.clinician,urm.community_health_services,urm.comorbidities_associate_diabetologist,urm.comorbidities_counselor,urm.comorbidities_diabetes_educator,urm.comorbidities_eye_screener,urm.comorbidities_foot_screener,urm.comorbidities_health_worker,urm.comorbidities_program_manager,urm.comorbidities_psychologist,urm.counselor,urm.data_entry_operator,urm.diabetes_educator,urm.facility_dot_provider,urm.fast_facilitator,urm.fast_field_supervisor,urm.fast_lab_technician,urm.fast_manager,urm.fast_program_manager,urm.fast_screener,urm.fast_site_manager,urm.field_supervisor,urm.health_worker,urm.implementer,urm.lab_technician,urm.medical_officer,urm.monitor,urm.pet_clinician,urm.pet_field_supervisor,urm.pet_health_worker,urm.pet_program_manager,urm.pet_psychologist,urm.pmdt_diabetes_educator,urm.pmdt_lab_technician,urm.pmdt_program_manager,urm.pmdt_treatment_coordinator,urm.pmdt_treatment_supporter,urm.program_manager,urm.provider,urm.psychologist,urm.referral_site_coordinator,urm.screener,urm.system_developer,urm.treatment_coordinator,urm.treatment_supporter FROM users AS u 
	LEFT JOIN provider AS p ON p.implementation_id = u.implementation_id AND p.provider_id = (select max(provider_id) from provider where person_id = u.person_id) 
	LEFT JOIN provider_attribute AS pa1 ON pa1.implementation_id = u.implementation_id AND pa1.provider_id = p.provider_id AND pa1.attribute_type_id = 1 AND pa1.voided = 0 
	LEFT JOIN user_role_merged AS urm ON urm.implementation_id = u.implementation_id AND urm.user_id = u.user_id 
	WHERE u.implementation_id = impl_id;

	-- Remove duplicate providers
	CREATE TABLE IF NOT EXISTS IF NOT EXISTS clean_provider SELECT * FROM
    provider
WHERE
    provider_id IN (SELECT 
            MIN(provider_id) AS provider_id
        FROM
            provider
        WHERE
            retired = 0
        GROUP BY identifier);

	TRUNCATE provider;
	INSERT INTO provider 
	SELECT * FROM clean_provider;

	DROP TABLE clean_provider;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `dim_patient`(IN impl_id INT, IN date_from DATETIME, IN date_to DATETIME)
BEGIN

DROP TABLE IF EXISTS person_latest_name;

CREATE TABLE IF NOT EXISTS person_latest_name SELECT * FROM
    person_name AS a
WHERE
    a.person_name_id = (SELECT 
            MAX(person_name_id)
        FROM
            person_name
        WHERE
            implementation_id = a.implementation_id
                AND person_id = a.person_id
                AND preferred = 1);

ALTER TABLE person_latest_name ADD PRIMARY KEY surrogate_id (surrogate_id), ADD INDEX person_index (person_id, person_name_id);

DROP TABLE IF EXISTS person_latest_address;

CREATE TABLE IF NOT EXISTS person_latest_address SELECT * FROM
    person_address AS a
WHERE
    a.person_address_id = (SELECT 
            MAX(person_address_id)
        FROM
            person_address
        WHERE
            implementation_id = a.implementation_id
                AND person_id = a.person_id
                AND preferred = 1);

ALTER TABLE person_latest_address ADD PRIMARY KEY surrogate_id (surrogate_id), ADD INDEX person_index (person_id, person_address_id);


DROP TABLE IF EXISTS patient_latest_identifier;

CREATE TABLE IF NOT EXISTS patient_latest_identifier SELECT implementation_id,
    patient_id,
    identifier_type,
    identifier,
    MAX(patient_identifier_id) AS max_patient_identifier_id FROM
    patient_identifier
WHERE
    implementation_id = impl_id
        AND voided = 0
GROUP BY implementation_id , patient_id , identifier_type;

ALTER TABLE patient_latest_identifier ADD INDEX identifier_id_index (patient_id, identifier_type, max_patient_identifier_id);

DROP TABLE IF EXISTS person_attribute_merged;

CREATE TABLE IF NOT EXISTS person_attribute_merged SELECT a.implementation_id,
    a.person_id,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 1,
            a.value,
            NULL)) AS race,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 2,
            a.value,
            NULL)) AS birthplace,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 3,
            a.value,
            NULL)) AS citizenship,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 4,
            a.value,
            NULL)) AS mother_name,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 5,
            a.value,
            NULL)) AS marital_status,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 6,
            a.value,
            NULL)) AS health_district,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 7,
            a.value,
            NULL)) AS health_center,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 8,
            a.value,
            NULL)) AS primary_contact,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 9,
            a.value,
            NULL)) AS unknown_patient,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 10,
            a.value,
            NULL)) AS test_patient,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 11,
            a.value,
            NULL)) AS primary_contact_owner,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 12,
            a.value,
            NULL)) AS secondary_contact,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 13,
            a.value,
            NULL)) AS secondary_contact_owner,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 14,
            a.value,
            NULL)) AS ethnicity,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 15,
            a.value,
            NULL)) AS education_level,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 16,
            a.value,
            NULL)) AS employment_status,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 17,
            a.value,
            NULL)) AS occupation,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 18,
            a.value,
            NULL)) AS mother_tongue,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 19,
            a.value,
            NULL)) AS income_class,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 20,
            a.value,
            NULL)) AS national_id,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 21,
            a.value,
            NULL)) AS national_id_owner,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 22,
            a.value,
            NULL)) AS guardian_name,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 23,
            a.value,
            NULL)) AS tertiary_contact,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 24,
            a.value,
            NULL)) AS quaternary_contact,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 25,
            a.value,
            NULL)) AS treatment_supporter,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 26,
            a.value,
            NULL)) AS other_identification_number,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 27,
            a.value,
            NULL)) AS transgender,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 28,
            a.value,
            NULL)) AS patient_type,
    GROUP_CONCAT(IF(a.person_attribute_type_id = 29,
            a.value,
            NULL)) AS email_address,
    '' AS BLANK FROM
    person_attribute AS a
WHERE
    a.voided = 0
GROUP BY a.implementation_id , a.person_id;

ALTER TABLE person_attribute_merged add primary key (implementation_id, person_id);

DELETE FROM gfatm_dw.dim_patient 
WHERE
    patient_id IN (SELECT 
        patient_id
    FROM
        patient
    
    WHERE
        date_changed BETWEEN date_from AND date_to);

INSERT IGNORE INTO dim_patient (surrogate_id, implementation_id, patient_id, patient_identifier, enrs, external_id,district_id, gender, birthdate, birthdate_estimated, dead, first_name, middle_name, last_name, address1, address2, city_village, state_province, postal_code, country, creator, date_created, changed_by, date_changed, voided, uuid, race,birthplace,citizenship,mother_name,marital_status,health_district,health_center,primary_contact,unknown_patient,test_patient,primary_contact_owner,secondary_contact,secondary_contact_owner,ethnicity,education_level,employment_status,occupation,mother_tongue,income_class,national_id,national_id_owner,guardian_name,tertiary_contact,quaternary_contact,treatment_supporter,other_identification_number,transgender,patient_type) 
SELECT p.surrogate_id, p.implementation_id, p.patient_id, pid.identifier AS patient_identifier, enrs.identifier AS enrs, eid.identifier AS external_id,dstb.identifier AS district_id, pr.gender, pr.birthdate, pr.birthdate_estimated, pr.dead, n.given_name AS first_name, n.middle_name, n.family_name AS last_name,  ad.address1, ad.address2, ad.city_village, ad.state_province, ad.postal_code, ad.country, p.creator, p.date_created, p.changed_by, p.date_changed, p.voided, pr.uuid, pam.race,pam.birthplace,pam.citizenship,pam.mother_name,pam.marital_status,pam.health_district,pam.health_center,pam.primary_contact,pam.unknown_patient,pam.test_patient,pam.primary_contact_owner,pam.secondary_contact,pam.secondary_contact_owner,pam.ethnicity,pam.education_level,pam.employment_status,pam.occupation,pam.mother_tongue,pam.income_class,pam.national_id,pam.national_id_owner,pam.guardian_name,pam.tertiary_contact,pam.quaternary_contact,pam.treatment_supporter,pam.other_identification_number,pam.transgender,pam.patient_type FROM patient AS p 
INNER JOIN person AS pr ON pr.implementation_id = p.implementation_id AND pr.person_id = p.patient_id 
INNER JOIN patient_latest_identifier AS pid ON pid.implementation_id = p.implementation_id AND pid.patient_id = p.patient_id AND pid.identifier_type = 3 
LEFT JOIN patient_latest_identifier AS enrs ON enrs.implementation_id = p.implementation_id AND enrs.patient_id = p.patient_id AND enrs.identifier_type = 4 
LEFT JOIN patient_latest_identifier AS eid ON eid.implementation_id = p.implementation_id AND eid.patient_id = p.patient_id AND eid.identifier_type = 5 
LEFT JOIN patient_latest_identifier AS dstb ON dstb.implementation_id = p.implementation_id AND dstb.patient_id = p.patient_id AND dstb.identifier_type = 7 
INNER JOIN person_latest_name AS n ON n.implementation_id = p.implementation_id AND n.person_id = pr.person_id AND n.preferred = 1 
LEFT JOIN person_latest_address AS ad ON ad.implementation_id = p.implementation_id AND ad.person_id = pr.person_id AND ad.preferred = 1 
LEFT JOIN person_attribute_merged AS pam ON pam.implementation_id = p.implementation_id AND pam.person_id = p.patient_id 
WHERE p.implementation_id = impl_id AND p.voided = 0 
AND NOT EXISTS (SELECT * FROM dim_patient WHERE implementation_id = p.implementation_id AND patient_id = p.patient_id)
AND ((p.date_created between date_from AND date_to) OR (p.date_changed between date_from AND date_to));

DROP TABLE IF EXISTS tmp_dim_patient;

CREATE TABLE IF NOT EXISTS tmp_dim_patient SELECT p.surrogate_id,
    p.implementation_id,
    p.patient_id,
    pid.identifier AS patient_identifier,
    enrs.identifier AS enrs,
    eid.identifier AS external_id,
    dstb.identifier AS district_id,
    pr.gender,
    pr.birthdate,
    pr.birthdate_estimated,
    pr.dead,
    n.given_name AS first_name,
    n.middle_name,
    n.family_name AS last_name,
    ad.address1,
    ad.address2,
    ad.city_village,
    ad.state_province,
    ad.postal_code,
    ad.country,
    p.creator,
    p.date_created,
    p.changed_by,
    p.date_changed,
    p.voided,
    pr.uuid,
    pam.race,
    pam.birthplace,
    pam.citizenship,
    pam.mother_name,
    pam.marital_status,
    pam.health_district,
    pam.health_center,
    pam.primary_contact,
    pam.unknown_patient,
    pam.test_patient,
    pam.primary_contact_owner,
    pam.secondary_contact,
    pam.secondary_contact_owner,
    pam.ethnicity,
    pam.education_level,
    pam.employment_status,
    pam.occupation,
    pam.mother_tongue,
    pam.income_class,
    pam.national_id,
    pam.national_id_owner,
    pam.guardian_name,
    pam.tertiary_contact,
    pam.quaternary_contact,
    pam.treatment_supporter,
    pam.other_identification_number,
    pam.transgender,
    pam.patient_type FROM
    patient AS p
        INNER JOIN
    person AS pr ON pr.implementation_id = p.implementation_id
        AND pr.person_id = p.patient_id
        INNER JOIN
    patient_latest_identifier AS pid ON pid.implementation_id = p.implementation_id
        AND pid.patient_id = p.patient_id
        AND pid.identifier_type = 3
        LEFT OUTER JOIN
    patient_latest_identifier AS enrs ON enrs.implementation_id = p.implementation_id
        AND enrs.patient_id = p.patient_id
        AND enrs.identifier_type = 4
        LEFT OUTER JOIN
    patient_latest_identifier AS eid ON eid.implementation_id = p.implementation_id
        AND eid.patient_id = p.patient_id
        AND eid.identifier_type = 5
        LEFT OUTER JOIN
    patient_latest_identifier AS dstb ON dstb.implementation_id = p.implementation_id
        AND dstb.patient_id = p.patient_id
        AND dstb.identifier_type = 7
        INNER JOIN
    person_latest_name AS n ON n.implementation_id = p.implementation_id
        AND n.person_id = pr.person_id
        AND n.preferred = 1
        LEFT OUTER JOIN
    person_latest_address AS ad ON ad.implementation_id = p.implementation_id
        AND ad.person_id = pr.person_id
        AND ad.preferred = 1
        LEFT OUTER JOIN
    person_attribute_merged AS pam ON pam.implementation_id = p.implementation_id
        AND pam.person_id = p.patient_id
WHERE
    p.implementation_id = impl_id
        AND p.voided = 0
        AND ((p.date_changed BETWEEN date_from AND date_to)
        OR (n.date_changed BETWEEN date_from AND date_to)
        OR (ad.date_changed BETWEEN date_from AND date_to));

UPDATE dim_patient AS dp,
    tmp_dim_patient AS tp 
SET 
    dp.patient_identifier = tp.patient_identifier,
    dp.enrs = tp.enrs,
    dp.external_id = tp.external_id,
    dp.district_id = tp.district_id,
    dp.gender = tp.gender,
    dp.birthdate = tp.birthdate,
    dp.birthdate_estimated = tp.birthdate_estimated,
    dp.dead = tp.dead,
    dp.first_name = tp.first_name,
    dp.middle_name = tp.middle_name,
    dp.last_name = tp.last_name,
    dp.address1 = tp.address1,
    dp.address2 = tp.address2,
    dp.city_village = tp.city_village,
    dp.state_province = tp.state_province,
    dp.postal_code = tp.postal_code,
    dp.country = tp.country,
    dp.creator = tp.creator,
    dp.date_created = tp.date_created,
    dp.changed_by = tp.changed_by,
    dp.date_changed = tp.date_changed,
    dp.voided = tp.voided,
    dp.uuid = tp.uuid,
    dp.race = tp.race,
    dp.birthplace = tp.birthplace,
    dp.citizenship = tp.citizenship,
    dp.mother_name = tp.mother_name,
    dp.marital_status = tp.marital_status,
    dp.health_district = tp.health_district,
    dp.health_center = tp.health_center,
    dp.primary_contact = tp.primary_contact,
    dp.unknown_patient = tp.unknown_patient,
    dp.test_patient = tp.test_patient,
    dp.primary_contact_owner = tp.primary_contact_owner,
    dp.secondary_contact = tp.secondary_contact,
    dp.secondary_contact_owner = tp.secondary_contact_owner,
    dp.ethnicity = tp.ethnicity,
    dp.education_level = tp.education_level,
    dp.employment_status = tp.employment_status,
    dp.occupation = tp.occupation,
    dp.mother_tongue = tp.mother_tongue,
    dp.income_class = tp.income_class,
    dp.national_id = tp.national_id,
    dp.national_id_owner = tp.national_id_owner,
    dp.guardian_name = tp.guardian_name,
    dp.tertiary_contact = tp.tertiary_contact,
    dp.quaternary_contact = tp.quaternary_contact,
    dp.treatment_supporter = tp.treatment_supporter,
    dp.other_identification_number = tp.other_identification_number,
    dp.transgender = tp.transgender,
    dp.patient_type = tp.patient_type
WHERE
    dp.implementation_id = tp.implementation_id
        AND dp.patient_id = tp.patient_id;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `dim_user_form`(IN impl_id INT, IN date_from DATETIME, IN date_to DATETIME)
BEGIN

INSERT INTO dim_user_form 
SELECT ut.surrogate_id, ut.implementation_id, ut.user_form_id, uft.user_form_type_id, uft.user_form_type, uft.description, ut.user_id, ut.created_at AS location_id, ut.date_entered, ut.date_created, ut.changed_by, ut.date_changed, ut.uuid FROM gfatm_user_form AS ut 
INNER JOIN gfatm_user_form_type AS uft ON uft.user_form_type_id = ut.user_form_type_id 
WHERE ut.implementation_id = impl_id 
AND NOT EXISTS (SELECT * FROM dim_user_form WHERE implementation_id = ut.implementation_id AND user_form_id = ut.user_form_id) 
AND ((ut.date_created BETWEEN date_from AND date_to) OR (ut.date_changed BETWEEN date_from AND date_to));

INSERT INTO dim_user_form_result 
SELECT ufr.surrogate_id, ufr.implementation_id, uf.user_form_type_id, ufr.user_form_result_id, ufr.user_form_id, ufr.element_id, e.element_name AS question, ufr.result AS answer, ufr.created_by AS user_id, ufr.created_at AS location_id, uf.date_entered, ufr.date_created, ufr.changed_by, ufr.date_changed, ufr.uuid FROM gfatm_user_form_result AS ufr 
INNER JOIN gfatm_user_form AS uf ON uf.implementation_id = ufr.implementation_id AND uf.user_form_id = ufr.user_form_id 
INNER JOIN gfatm_element AS e ON e.implementation_id = ufr.implementation_id AND e.element_id = ufr.element_id 
WHERE ufr.implementation_id = impl_id 
AND NOT EXISTS (SELECT * FROM dim_user_form_result WHERE implementation_id = ufr.implementation_id AND user_form_result_id = ufr.user_form_result_id) 
AND ((ufr.date_created BETWEEN date_from AND date_to) OR (ufr.date_changed BETWEEN date_from AND date_to));

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `dim_encounter`(IN impl_id INT, IN date_from DATETIME, IN date_to DATETIME)
BEGIN

INSERT IGNORE INTO dim_encounter 
SELECT e.surrogate_id, e.implementation_id, e.encounter_id, e.encounter_type, et.name AS encounter_name, et.description, e.patient_id, e.location_id, p.identifier AS provider, e.encounter_datetime AS date_entered, e.creator, e.date_created AS date_start, e.changed_by, e.date_changed, e.date_created AS date_end, e.uuid FROM encounter AS e 
INNER JOIN encounter_type AS et ON et.implementation_id = e.implementation_id AND et.encounter_type_id = e.encounter_type AND et.retired = 0 
LEFT JOIN encounter_provider AS ep ON ep.implementation_id = e.implementation_id AND ep.encounter_id = e.encounter_id AND ep.voided = 0 
LEFT JOIN provider AS p ON p.implementation_id = e.implementation_id AND p.provider_id = ep.provider_id AND p.retired = 0 
WHERE e.voided = 0 AND NOT EXISTS (SELECT * FROM dim_encounter WHERE implementation_id = e.implementation_id AND encounter_id = e.encounter_id) 
AND ((e.date_created BETWEEN date_from AND date_to) or (e.date_changed BETWEEN date_from AND date_to));

-- Delete all past encounters FROM dimension, which are now voided
CREATE TABLE IF NOT EXISTS temp_voided SELECT encounter_id FROM
    encounter
WHERE
    voided = 1
        AND encounter_id IN (SELECT 
            encounter_id
        FROM
            dim_encounter);
DELETE FROM dim_encounter 
WHERE
    encounter_id IN (SELECT 
        encounter_id
    FROM
        temp_voided);
DROP TABLE temp_voided;

DROP TABLE IF EXISTS tmp_dim_encounter;
CREATE TABLE IF NOT EXISTS tmp_dim_encounter SELECT e.surrogate_id,
    e.implementation_id,
    e.encounter_id,
    e.encounter_type,
    et.name AS encounter_name,
    et.description,
    e.patient_id,
    e.location_id,
    p.identifier AS provider,
    e.encounter_datetime AS date_entered,
    e.creator,
    e.date_created AS date_start,
    e.changed_by,
    e.date_changed,
    e.date_created AS date_end,
    e.uuid FROM
    encounter AS e
        INNER JOIN
    encounter_type AS et ON et.implementation_id = e.implementation_id
        AND et.encounter_type_id = e.encounter_type
        AND et.retired = 0
        LEFT JOIN
    encounter_provider AS ep ON ep.implementation_id = e.implementation_id
        AND ep.encounter_id = e.encounter_id
        AND ep.voided = 0
        LEFT JOIN
    provider AS p ON p.implementation_id = e.implementation_id
        AND p.provider_id = ep.provider_id
        AND p.retired = 0
WHERE
    e.voided = 0
        AND (e.date_changed BETWEEN date_from AND date_to);

UPDATE dim_encounter AS de,
    tmp_dim_encounter AS t 
SET 
    de.patient_id = t.patient_id,
    de.location_id = t.location_id,
    de.provider = t.provider,
    de.date_entered = t.date_entered
WHERE
    de.implementation_id = t.implementation_id
        AND de.encounter_id = t.encounter_id
        AND de.encounter_type = t.encounter_type;


END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `dim_obs`(IN impl_id INT, IN date_from DATETIME, IN date_to DATETIME)
BEGIN

INSERT IGNORE INTO dim_obs 
INNER JOIN dim_patient AS p ON p.implementation_id = e.implementation_id AND p.patient_id = e.patient_id 
WHERE o.voided = 0 AND NOT EXISTS (SELECT * FROM dim_obs WHERE implementation_id = o.implementation_id AND obs_id = o.obs_id) 
AND (o.date_created BETWEEN date_from AND date_to);

DROP TABLE IF EXISTS tmp_group_obs;

-- Delete all past observations FROM dimension, which are now null
DELETE FROM dim_obs 
WHERE
    obs_id IN (SELECT 
        previous_version
    FROM
        obs
    
    WHERE
        previous_version IS NOT NULL);
DELETE FROM dim_obs 
WHERE
    obs_id IN (SELECT 
        obs_id
    FROM
        obs
    
    WHERE
        voided = 1);

CREATE TABLE IF NOT EXISTS tmp_group_obs SELECT implementation_id,
    encounter_type,
    obs_group_id,
    question,
    GROUP_CONCAT(CASE answer
            WHEN '' THEN NULL
            ELSE answer
        END) AS answer FROM
    dim_obs
WHERE
    implementation_id = impl_id
        AND obs_group_id IS NOT NULL
GROUP BY implementation_id , obs_group_id , encounter_type
HAVING answer IS NOT NULL;

UPDATE dim_obs AS o,
    tmp_group_obs AS t 
SET 
    o.answer = t.answer
WHERE
    o.implementation_id = t.implementation_id
        AND o.obs_id = t.obs_group_id;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE dw_direct_reset_update()
BEGIN

TRUNCATE TABLE tmp_gfatm_element; 
TRUNCATE TABLE tmp_gfatm_location;
TRUNCATE TABLE tmp_gfatm_location_attribute;
TRUNCATE TABLE tmp_gfatm_location_attribute_type;
TRUNCATE TABLE tmp_gfatm_user_attribute; 
TRUNCATE TABLE tmp_gfatm_user_attribute_type;
TRUNCATE TABLE tmp_gfatm_user_form; 
TRUNCATE TABLE tmp_gfatm_user_form_result;
TRUNCATE TABLE tmp_gfatm_user_form_type; 
TRUNCATE TABLE tmp_gfatm_user_location;
TRUNCATE TABLE tmp_gfatm_user_role; 
TRUNCATE TABLE tmp_gfatm_users;

TRUNCATE TABLE gfatm_element; 
TRUNCATE TABLE gfatm_location;
TRUNCATE TABLE gfatm_location_attribute;
TRUNCATE TABLE gfatm_location_attribute_type;
TRUNCATE TABLE gfatm_user_attribute; 
TRUNCATE TABLE gfatm_user_attribute_type;
TRUNCATE TABLE gfatm_user_form; 
TRUNCATE TABLE gfatm_user_form_result;
TRUNCATE TABLE gfatm_user_form_type; 
TRUNCATE TABLE gfatm_user_location;
TRUNCATE TABLE gfatm_user_role; 
TRUNCATE TABLE gfatm_users;

TRUNCATE TABLE tmp_person; 
TRUNCATE TABLE tmp_person_attribute;
TRUNCATE TABLE tmp_person_attribute_type; 
TRUNCATE TABLE tmp_person_address;
TRUNCATE TABLE tmp_person_name; 
TRUNCATE TABLE tmp_role; 
TRUNCATE TABLE tmp_role_role;
TRUNCATE TABLE tmp_privilege; 
TRUNCATE TABLE tmp_role_privilege; 
TRUNCATE TABLE tmp_users;
TRUNCATE TABLE tmp_user_property; 
TRUNCATE TABLE tmp_user_role;
TRUNCATE TABLE tmp_provider_attribute_type; 
TRUNCATE TABLE tmp_provider;
TRUNCATE TABLE tmp_provider_attribute; 
TRUNCATE TABLE tmp_location_attribute_type;
TRUNCATE TABLE tmp_location;
TRUNCATE TABLE tmp_location_attribute;
TRUNCATE TABLE tmp_location_tag;
TRUNCATE TABLE tmp_location_tag_map;
TRUNCATE TABLE tmp_concept_class;
TRUNCATE TABLE tmp_concept_set;
TRUNCATE TABLE tmp_concept_datatype;
TRUNCATE TABLE tmp_concept_map_type;
TRUNCATE TABLE tmp_concept;
TRUNCATE TABLE tmp_concept_name;
TRUNCATE TABLE tmp_concept_description;
TRUNCATE TABLE tmp_concept_answer;
TRUNCATE TABLE tmp_concept_numeric;
TRUNCATE TABLE tmp_patient_identifier_type;
TRUNCATE TABLE tmp_patient;
TRUNCATE TABLE tmp_patient_identifier;
TRUNCATE TABLE tmp_patient_program;
TRUNCATE TABLE tmp_encounter_type;
TRUNCATE TABLE tmp_form;
TRUNCATE TABLE tmp_encounter_role;
TRUNCATE TABLE tmp_encounter;
TRUNCATE TABLE tmp_encounter_provider;
TRUNCATE TABLE tmp_obs;
TRUNCATE TABLE tmp_visit_type;
TRUNCATE TABLE tmp_visit_attribute_type;
TRUNCATE TABLE tmp_visit_attribute;
TRUNCATE TABLE tmp_field;
TRUNCATE TABLE tmp_field_answer;
TRUNCATE TABLE tmp_field_type;
TRUNCATE TABLE tmp_form_field;

TRUNCATE TABLE person; 
TRUNCATE TABLE person_attribute;
TRUNCATE TABLE person_attribute_type; 
TRUNCATE TABLE person_address;
TRUNCATE TABLE person_name; 
TRUNCATE TABLE role; 
TRUNCATE TABLE role_role;
TRUNCATE TABLE privilege; 
TRUNCATE TABLE role_privilege; 
TRUNCATE TABLE users;
TRUNCATE TABLE user_property; 
TRUNCATE TABLE user_role;
TRUNCATE TABLE provider_attribute_type; 
TRUNCATE TABLE provider;
TRUNCATE TABLE provider_attribute; 
TRUNCATE TABLE location_attribute_type;
TRUNCATE TABLE location;
TRUNCATE TABLE location_attribute;
TRUNCATE TABLE location_tag;
TRUNCATE TABLE location_tag_map;
TRUNCATE TABLE concept_class;
TRUNCATE TABLE concept_set;
TRUNCATE TABLE concept_datatype;
TRUNCATE TABLE concept_map_type;
TRUNCATE TABLE concept;
TRUNCATE TABLE concept_name;
TRUNCATE TABLE concept_description;
TRUNCATE TABLE concept_answer;
TRUNCATE TABLE concept_numeric;
TRUNCATE TABLE patient_identifier_type;
TRUNCATE TABLE patient;
TRUNCATE TABLE patient_identifier;
TRUNCATE TABLE patient_program;
TRUNCATE TABLE encounter_type;
TRUNCATE TABLE form;
TRUNCATE TABLE encounter_role;
TRUNCATE TABLE encounter;
TRUNCATE TABLE encounter_provider;
TRUNCATE TABLE obs;
TRUNCATE TABLE visit_type;
TRUNCATE TABLE visit_attribute_type;
TRUNCATE TABLE visit_attribute;
TRUNCATE TABLE field;
TRUNCATE TABLE field_answer;
TRUNCATE TABLE field_type;
TRUNCATE TABLE form_field;

INSERT INTO gfatm_location_attribute_type (surrogate_id, implementation_id, location_attribute_type_id, attribute_name, validation_regex, required, description, date_created, created_by, created_at, date_changed, changed_by, changed_at, data_type, uuid) 
SELECT 0, 1, location_attribute_type_id, attribute_name, validation_regex, required, description, date_created, created_by, created_at, date_changed, changed_by, changed_at, data_type, uuid FROM gfatm.location_attribute_type;

INSERT INTO gfatm_location (surrogate_id, implementation_id, location_id, location_name, category, description, address1, address2, address3, city_village, state_province, country, landmark1, landmark2, latitude, longitude, primary_contact, secondary_contact, email, fax, parent_location, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, location_id, location_name, category, description, address1, address2, address3, city_village, state_province, country, landmark1, landmark2, latitude, longitude, primary_contact, secondary_contact, email, fax, parent_location, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.location;

INSERT INTO gfatm_location_attribute (surrogate_id, implementation_id, location_attribute_id, attribute_type_id, location_id, attribute_value, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, location_attribute_id, attribute_type_id, location_id, attribute_value, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.location_attribute;

INSERT INTO gfatm_users (surrogate_id, implementation_id, user_id, username, full_name, global_data_access, disabled, reason_disabled, password_hash, password_salt, secret_question, secret_answer_hash, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_id, username, full_name, global_data_access, disabled, reason_disabled, password_hash, password_salt, secret_question, secret_answer_hash, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.users;

INSERT INTO gfatm_user_attribute_type (surrogate_id, implementation_id, user_attribute_type_id, attribute_name, data_type, date_changed, date_created, description, required, validation_regex, changed_at, created_at, changed_by, created_by, uuid) 
SELECT 0, 1, user_attribute_type_id, attribute_name, data_type, date_changed, date_created, description, required, validation_regex, changed_at, created_at, changed_by, created_by, uuid FROM gfatm.user_attribute_type;

INSERT INTO gfatm_user_attribute (surrogate_id, implementation_id, user_attribute_id, attribute_value, date_changed, date_created, changed_at, created_at, user_attribute_type_id, user_id, changed_by, created_by, uuid) 
SELECT 0, 1, user_attribute_id, attribute_value, date_changed, date_created, changed_at, created_at, user_attribute_type_id, user_id, changed_by, created_by, uuid FROM gfatm.user_attribute;

INSERT INTO gfatm_user_role (surrogate_id, implementation_id, user_id, role_id, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_id, role_id, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_role;

INSERT INTO gfatm_user_location (surrogate_id, implementation_id, user_id, location_id, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_id, location_id, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_location;

INSERT INTO gfatm_element (surrogate_id, implementation_id, element_id, element_name, validation_regex, data_type, description, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, element_id, element_name, validation_regex, data_type, description, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.element;

INSERT INTO gfatm_user_form_type (surrogate_id, implementation_id, user_form_type_id, user_form_type, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid, description) 
SELECT 0, 1, user_form_type_id, user_form_type, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid, description FROM gfatm.user_form_type;

INSERT INTO gfatm_user_form (surrogate_id, implementation_id, user_form_id, user_form_type_id, user_id, duration_seconds, date_entered, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_form_id, user_form_type_id, user_id, duration_seconds, date_entered, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_form;

INSERT INTO person (surrogate_id, implementation_id, person_id, gender, birthdate, birthdate_estimated, dead, death_date, cause_of_death, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason, uuid) 
SELECT 0, 1, person_id, gender, birthdate, birthdate_estimated, dead, death_date, cause_of_death, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason, uuid FROM openmrs.person;

INSERT INTO person_attribute_type (surrogate_id, implementation_id, person_attribute_type_id, name, description, format, foreign_key, searchable, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, edit_privilege, sort_weight, uuid) 
SELECT 0, 1, person_attribute_type_id, name, description, format, foreign_key, searchable, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, edit_privilege, sort_weight, uuid FROM openmrs.person_attribute_type;

INSERT INTO person_attribute (surrogate_id, implementation_id, person_attribute_id, person_id, value, person_attribute_type_id, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason, uuid) 
SELECT 0, 1, person_attribute_id, person_id, value, person_attribute_type_id, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason, uuid FROM openmrs.person_attribute;

INSERT INTO person_address (surrogate_id, implementation_id, person_address_id, person_id, preferred, address1, address2, city_village, state_province, postal_code, country, latitude, longitude, start_date, end_date, creator, date_created, voided, voided_by, date_voided, void_reason, county_district, address3, address4, address5, address6, date_changed, changed_by, uuid) 
SELECT 0, 1, person_address_id, person_id, preferred, address1, address2, city_village, state_province, postal_code, country, latitude, longitude, start_date, end_date, creator, date_created, voided, voided_by, date_voided, void_reason, county_district, address3, address4, address5, address6, date_changed, changed_by, uuid FROM openmrs.person_address;

INSERT INTO person_name (surrogate_id, implementation_id, person_name_id, preferred, person_id, prefix, given_name, middle_name, family_name_prefix, family_name, family_name2, family_name_suffix, degree, creator, date_created, voided, voided_by, date_voided, void_reason, changed_by, date_changed, uuid) 
SELECT 0, 1, person_name_id, preferred, person_id, prefix, given_name, middle_name, family_name_prefix, family_name, family_name2, family_name_suffix, degree, creator, date_created, voided, voided_by, date_voided, void_reason, changed_by, date_changed, uuid FROM openmrs.person_name;

INSERT INTO role (surrogate_id, implementation_id, role, description, uuid) 
SELECT 0, 1, role, description, uuid FROM openmrs.role;

INSERT INTO role_role (surrogate_id, implementation_id, parent_role, child_role) 
SELECT 0, 1, parent_role, child_role FROM openmrs.role_role;

INSERT INTO privilege (surrogate_id, implementation_id, privilege, description, uuid) 
SELECT 0, 1, privilege, description, uuid FROM openmrs.privilege;

INSERT INTO role_privilege (surrogate_id, implementation_id, role, privilege) 
SELECT 0, 1, role, privilege FROM openmrs.role_privilege;

INSERT INTO users (surrogate_id, implementation_id, user_id, system_id, username, password, salt, secret_question, secret_answer, creator, date_created, changed_by, date_changed, person_id, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, user_id, system_id, username, password, salt, secret_question, secret_answer, creator, date_created, changed_by, date_changed, person_id, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.users;

INSERT INTO user_property (surrogate_id, implementation_id, user_id, property, property_value) 
SELECT 0, 1, user_id, property, property_value FROM openmrs.user_property;

INSERT INTO user_role (surrogate_id, implementation_id, user_id, role) 
SELECT 0, 1, user_id, role FROM openmrs.user_role;

INSERT INTO provider_attribute_type (surrogate_id, implementation_id, provider_attribute_type_id, name, description, datatype, datatype_config, preferred_handler, handler_config, min_occurs, max_occurs, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, provider_attribute_type_id, name, description, datatype, datatype_config, preferred_handler, handler_config, min_occurs, max_occurs, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.provider_attribute_type;

INSERT INTO provider (surrogate_id, implementation_id, provider_id, person_id, name, identifier, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, provider_id, person_id, name, identifier, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.provider;

INSERT INTO provider_attribute (surrogate_id, implementation_id, provider_attribute_id, provider_id, attribute_type_id, value_reference, uuid, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason) 
SELECT 0, 1, provider_attribute_id, provider_id, attribute_type_id, value_reference, uuid, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason FROM openmrs.provider_attribute;

INSERT INTO location_attribute_type (surrogate_id, implementation_id, location_attribute_type_id, name, description, datatype, datatype_config, preferred_handler, handler_config, min_occurs, max_occurs, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, location_attribute_type_id, name, description, datatype, datatype_config, preferred_handler, handler_config, min_occurs, max_occurs, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.location_attribute_type;

INSERT INTO location (surrogate_id, implementation_id, location_id, name, description, address1, address2, city_village, state_province, postal_code, country, latitude, longitude, creator, date_created, county_district, address3, address4, address5, address6, retired, retired_by, date_retired, retire_reason, parent_location, uuid, changed_by, date_changed) 
SELECT 0, 1, location_id, name, description, address1, address2, city_village, state_province, postal_code, country, latitude, longitude, creator, date_created, county_district, address3, address4, address5, address6, retired, retired_by, date_retired, retire_reason, parent_location, uuid, changed_by, date_changed FROM openmrs.location;

INSERT INTO location_attribute (surrogate_id, implementation_id, location_attribute_id, location_id, attribute_type_id, value_reference, uuid, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason) 
SELECT 0, 1, location_attribute_id, location_id, attribute_type_id, value_reference, uuid, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason FROM openmrs.location_attribute;

INSERT INTO location_tag (surrogate_id, implementation_id, location_tag_id, name, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid, changed_by, date_changed) 
SELECT 0, 1, location_tag_id, name, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid, changed_by, date_changed FROM openmrs.location_tag;

INSERT INTO location_tag_map (surrogate_id, implementation_id, location_id, location_tag_id) 
SELECT 0, 1, location_id, location_tag_id FROM openmrs.location_tag_map;

INSERT INTO concept_class (surrogate_id, implementation_id, concept_class_id, name, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, concept_class_id, name, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.concept_class;

INSERT INTO concept_set (surrogate_id, implementation_id, concept_set_id, concept_id, concept_set, sort_weight, creator, date_created, uuid) 
SELECT 0, 1, concept_set_id, concept_id, concept_set, sort_weight, creator, date_created, uuid FROM openmrs.concept_set;

INSERT INTO concept_datatype (surrogate_id, implementation_id, concept_datatype_id, name, hl7_abbreviation, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, concept_datatype_id, name, hl7_abbreviation, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.concept_datatype;

INSERT INTO concept_map_type (surrogate_id, implementation_id, concept_map_type_id, name, description, creator, date_created, changed_by, date_changed, is_hidden, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, concept_map_type_id, name, description, creator, date_created, changed_by, date_changed, is_hidden, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.concept_map_type;

INSERT INTO concept (surrogate_id, implementation_id, concept_id, retired, short_name, description, form_text, datatype_id, class_id, is_set, creator, date_created, version, changed_by, date_changed, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, concept_id, retired, short_name, description, form_text, datatype_id, class_id, is_set, creator, date_created, version, changed_by, date_changed, retired_by, date_retired, retire_reason, uuid FROM openmrs.concept;

INSERT INTO concept_name (surrogate_id, implementation_id, concept_id, name, locale, creator, date_created, concept_name_id, voided, voided_by, date_voided, void_reason, uuid, concept_name_type, locale_preferred, date_changed, changed_by) 
SELECT 0, 1, concept_id, name, locale, creator, date_created, concept_name_id, voided, voided_by, date_voided, void_reason, uuid, concept_name_type, locale_preferred, date_changed, changed_by FROM openmrs.concept_name;

INSERT INTO concept_description (surrogate_id, implementation_id, concept_description_id, concept_id, description, locale, creator, date_created, changed_by, date_changed, uuid) 
SELECT 0, 1, concept_description_id, concept_id, description, locale, creator, date_created, changed_by, date_changed, uuid FROM openmrs.concept_description;

INSERT INTO concept_answer (surrogate_id, implementation_id, concept_answer_id, concept_id, answer_concept, answer_drug, creator, date_created, uuid, sort_weight) 
SELECT 0, 1, concept_answer_id, concept_id, answer_concept, answer_drug, creator, date_created, uuid, sort_weight FROM openmrs.concept_answer;

INSERT INTO concept_numeric (surrogate_id, implementation_id, concept_id, hi_absolute, hi_critical, hi_normal, low_absolute, low_critical, low_normal, units, precise, display_precision) 
SELECT 0, 1, concept_id, hi_absolute, hi_critical, hi_normal, low_absolute, low_critical, low_normal, units, precise, display_precision FROM openmrs.concept_numeric;

INSERT INTO patient_identifier_type (surrogate_id, implementation_id, patient_identifier_type_id, name, description, format, check_digit, creator, date_created, required, format_description, validator, location_behavior, retired, retired_by, date_retired, retire_reason, uuid, uniqueness_behavior) 
SELECT 0, 1, patient_identifier_type_id, name, description, format, check_digit, creator, date_created, required, format_description, validator, location_behavior, retired, retired_by, date_retired, retire_reason, uuid, uniqueness_behavior FROM openmrs.patient_identifier_type;

INSERT INTO patient (surrogate_id, implementation_id, patient_id, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason) 
SELECT 0, 1, patient_id, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason FROM openmrs.patient;

INSERT INTO patient_identifier (surrogate_id, implementation_id, patient_identifier_id, patient_id, identifier, identifier_type, preferred, location_id, creator, date_created, date_changed, changed_by, voided, voided_by, date_voided, void_reason, uuid) 
SELECT 0, 1, patient_identifier_id, patient_id, identifier, identifier_type, preferred, location_id, creator, date_created, date_changed, changed_by, voided, voided_by, date_voided, void_reason, uuid FROM openmrs.patient_identifier;

INSERT INTO patient_program (surrogate_id, implementation_id, patient_program_id, patient_id, program_id, date_enrolled, date_completed, location_id, outcome_concept_id, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason, uuid) 
SELECT 0, 1, patient_program_id, patient_id, program_id, date_enrolled, date_completed, location_id, outcome_concept_id, creator, date_created, changed_by, date_changed, voided, voided_by, date_voided, void_reason, uuid FROM openmrs.patient_program;

INSERT INTO encounter_type (surrogate_id, implementation_id, encounter_type_id, name, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid, edit_privilege, view_privilege) 
SELECT 0, 1, encounter_type_id, name, description, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid, edit_privilege, view_privilege FROM openmrs.encounter_type;

INSERT INTO encounter_role (surrogate_id, implementation_id, encounter_role_id, name, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid) 
SELECT 0, 1, encounter_role_id, name, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid FROM openmrs.encounter_role;

INSERT INTO encounter (surrogate_id, implementation_id, encounter_id, encounter_type, patient_id, location_id, form_id, encounter_datetime, creator, date_created, voided, voided_by, date_voided, void_reason, changed_by, date_changed, visit_id, uuid) 
SELECT 0, 1, encounter_id, encounter_type, patient_id, location_id, form_id, encounter_datetime, creator, date_created, voided, voided_by, date_voided, void_reason, changed_by, date_changed, visit_id, uuid FROM openmrs.encounter;

INSERT INTO encounter_provider (surrogate_id, implementation_id, encounter_provider_id, encounter_id, provider_id, encounter_role_id, creator, date_created, changed_by, date_changed, voided, date_voided, voided_by, void_reason, uuid) 
SELECT 0, 1, encounter_provider_id, encounter_id, provider_id, encounter_role_id, creator, date_created, changed_by, date_changed, voided, date_voided, voided_by, void_reason, uuid FROM openmrs.encounter_provider;

INSERT INTO gfatm_user_form_result (surrogate_id, implementation_id, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_form_result
WHERE user_form_result_id BETWEEN 1 AND 5000000;

INSERT INTO gfatm_user_form_result (surrogate_id, implementation_id, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_form_result
WHERE user_form_result_id BETWEEN 5000001 AND 10000000;

INSERT INTO gfatm_user_form_result (surrogate_id, implementation_id, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_form_result
WHERE user_form_result_id BETWEEN 10000000 AND 15000000;

INSERT INTO gfatm_user_form_result (surrogate_id, implementation_id, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_form_result
WHERE user_form_result_id BETWEEN 15000000 AND 20000000;

INSERT INTO gfatm_user_form_result (surrogate_id, implementation_id, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) 
SELECT 0, 1, user_form_result_id, user_form_id, element_id, result, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM gfatm.user_form_result
WHERE user_form_result_id > 20000000;


INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 1 AND 10000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 10000001 AND 20000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 20000001 AND 30000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 30000001 AND 40000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 40000001 AND 50000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 50000001 AND 60000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 50000001 AND 60000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id BETWEEN 60000001 AND 70000000;

INSERT INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) 
SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.obs 
WHERE obs_id > 70000000;

-- Archived data
INSERT IGNORE INTO encounter (surrogate_id, implementation_id, encounter_id, encounter_type, patient_id, location_id, form_id, encounter_datetime, creator, date_created, voided, voided_by, date_voided, void_reason, changed_by, date_changed, visit_id, uuid) 
SELECT 0, 1, encounter_id, encounter_type, patient_id, location_id, form_id, encounter_datetime, creator, date_created, voided, voided_by, date_voided, void_reason, changed_by, date_changed, visit_id, uuid FROM openmrs.archived_encounter;

INSERT IGNORE INTO encounter_provider (surrogate_id, implementation_id, encounter_provider_id, encounter_id, provider_id, encounter_role_id, creator, date_created, changed_by, date_changed, voided, date_voided, voided_by, void_reason, uuid) 
SELECT 0, 1, encounter_provider_id, encounter_id, provider_id, encounter_role_id, creator, date_created, changed_by, date_changed, voided, date_voided, voided_by, void_reason, uuid FROM openmrs.archived_encounter_provider;

INSERT IGNORE INTO obs (surrogate_id, implementation_id, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version) SELECT 0, 1, obs_id, person_id, concept_id, encounter_id, order_id, obs_datetime, location_id, obs_group_id, accession_number, value_group_id, value_coded, value_coded_name_id, value_drug, value_datetime, value_numeric, value_modifier, value_text, value_complex, comments, creator, date_created, voided, voided_by, date_voided, void_reason, uuid, previous_version FROM openmrs.archived_obs;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE fact_modeling()
BEGIN

DROP TABLE IF EXISTS fact_patient_encounter;
CREATE TABLE IF NOT EXISTS fact_patient_encounter 
SELECT de.implementation_id, de.patient_id, de.encounter_type, de.encounter_name, min(de.encounter_id) as first_encounter_id, max(de.encounter_id) as last_encounter_id, min(de.date_entered) as first_encounter_date, max(de.date_entered) as last_encounter_date FROM dim_encounter AS de
GROUP BY de.implementation_id, de.patient_id, de.encounter_type;
ALTER TABLE fact_patient_encounter ADD PRIMARY KEY (implementation_id, patient_id, encounter_type),
ADD INDEX first_enc_idx (first_encounter_id ASC),
ADD INDEX last_enc_idx (last_encounter_id ASC);

-- common informationn from pet index registration, fast treatment initiation and childhood tb treatment initiation

drop table if exists common_form_4_29_67;
CREATE TABLE IF NOT EXISTS common_form_4_29_67
 SELECT e.implementation_id AS implementation_id, e.encounter_id AS encounter_id, e.provider AS provider, e.location_id AS location_id,	l.location_name AS location_name, e.patient_id AS patient_id, date(e.date_entered) AS date_entered, GROUP_CONCAT(IF((o.question = 'tb_infection_type'), o.answer, NULL) SEPARATOR ',') AS tb_infection_type, GROUP_CONCAT(IF((o.question = 'tb_type'), o.answer, NULL) SEPARATOR ',') AS tb_type, GROUP_CONCAT(IF((o.question = 'dst_pattern'), o.answer, NULL) SEPARATOR ',') AS dst_pattern, GROUP_CONCAT(IF((o.question = 'treatment_enrollment_date'), o.answer,  NULL) SEPARATOR ',') AS treatment_enrollment_date, GROUP_CONCAT(IF((o.question = 'district'), o.answer, NULL) SEPARATOR ',') AS district, GROUP_CONCAT(IF((o.question = 'address_type'), o.answer, NULL) SEPARATOR ',') AS address_type,  GROUP_CONCAT(IF((o.question = 'diagnosis_type'), o.answer, NULL) SEPARATOR ',') AS diagnosis_type, GROUP_CONCAT(IF((o.question = 'primary_contact'), o.answer, NULL) SEPARATOR ',') AS primary_contact, GROUP_CONCAT(IF((o.question = 'secondary_contact'), o.answer,  NULL) SEPARATOR ',') AS secondary_contact, GROUP_CONCAT(IF((o.question = 'address1'),  o.answer,  NULL) SEPARATOR ',') AS address1, GROUP_CONCAT(IF((o.question = 'city_village'),  o.answer,  NULL) SEPARATOR ',') AS city_village, GROUP_CONCAT(IF((o.question = 'registration_date'),   o.answer, NULL)  SEPARATOR ',') AS registration_date, GROUP_CONCAT(IF((o.question = 'tb_registration_no'),   o.answer, NULL)  SEPARATOR ',') AS tb_registration_no FROM ((dim_encounter e JOIN dim_obs o ON (((o.encounter_id = e.encounter_id) AND (o.voided = 0)))) JOIN dim_location l ON ((l.location_id = e.location_id))) WHERE ((e.encounter_type IN (4 , 29, 210)) AND ISNULL(o.obs_group_id)) and e.encounter_id=(select max(encounter_id) from dim_encounter where encounter_type IN (4 , 29, 210) and patient_id=e.patient_id) GROUP BY  e.implementation_id , e.encounter_id , e.patient_id , e.provider , e.location_id , e.date_entered;
alter table common_form_4_29_67 add PRIMARY KEY (encounter_id), add KEY encounter_id (encounter_id), add  KEY patient_id (patient_id), add  KEY location_id (location_id), add  KEY date_entered (date_entered);

-- Dummy entry for pet baseline screening
 insert into enc_pet_baseline_screening (surrogate_id,implementation_id,provider,location_id,location_name,patient_id, date_entered,index_patient_id,patient_source) select surrogate_id,implementation_id,provider,location_id,location_name,patient_id,date_entered,index_patient_id,patient_source from enc_clinician_evaluation ce where index_patient_id is not null and patient_id not in 
 (select patient_id from enc_pet_baseline_screening ) and encounter_id=(select max(encounter_id) from enc_clinician_evaluation where patient_id=ce.patient_id);

update person_address set address4 = 'Baldia Town' where address2 like '%Baldia%';
update person_address set address4 = 'Bin Qasim Town' where address2 like '%Qasim%';
update person_address set address4 = 'Gadap Town' where address2 like '%Gadap%';
update person_address set address4 = 'Gulberg Town' where address2 like '%Gulb%rg%';
update person_address set address4 = 'Gulshan Town' where address2 like '%Gulshan%';
update person_address set address4 = 'Jamshed Town' where address2 like '%Jamsh%d%';
update person_address set address4 = 'Kemari Town' where address2 like '%K%mari%';
update person_address set address4 = 'Korangi Town' where address2 like '%Korangi%';
update person_address set address4 = 'Landhi Town' where address2 like '%L%ndhi%';
update person_address set address4 = 'Liaquatabad Town' where address2 like '%L%q%t%bad%';
update person_address set address4 = 'Lyari Town' where address2 like '%L_ari%';
update person_address set address4 = 'Malir Town' where address2 like '%Malir%';
update person_address set address4 = 'New Karachi Town' where address2 like '%New%Karachi%';
update person_address set address4 = 'North Nazimabad Town' where address2 like '%Naz_mabad%';
update person_address set address4 = 'Orangi Town' where address2 like '%Orangi%';
update person_address set address4 = 'Saddar Town' where address2 like '%Sad_ar%';
update person_address set address4 = 'Shah Faisal Town' where address2 like '%Shah%';
update person_address set address4 = 'SITE Town' where address2 like '%SITE%';

delete from gfatm_dw.fact_encounter where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
 
insert into fact_encounter SELECT e.implementation_id, t.datetime_id, e.encounter_type, e.location_id, SUM(IF(e.encounter_name LIKE 'FAST%', 1, 0)) AS fast_total, SUM(IF(e.encounter_name LIKE 'PET%', 1, 0)) AS pet_total, SUM(IF(e.encounter_name LIKE 'Comorbidities%', 1, 0)) AS comorbidities_total, SUM(IF(e.encounter_name LIKE 'Childhood TB%', 1, 0)) AS childhoodtb_total, SUM(IF(e.encounter_name LIKE 'PMDT%', 1, 0)) AS pmdt_total, COUNT(*) as total FROM dim_encounter AS e INNER JOIN dim_datetime AS t ON DATE(t.full_date) = DATE(e.date_entered) 
 
where t.full_date >=(current_date()-interval 1 month) GROUP BY e.implementation_id, t.datetime_id, e.encounter_type, e.location_id;

delete from gfatm_dw.fact_fast_dsss where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));


insert into gfatm_dw.fact_fast_dsss (implementation_id,datetime_id,location_id,total_screening,chest_xrays,Verbal_Screen_Presumptives,Chest_XRay_Presumptives,Samples_Collected_Verbal_Screen_Presumptives,Samples_Collected_CXR_Presumptives,
GXP_Tests_Done,Internal_Tests,External_Tests,MTBpve_Internal,MTBpve_External,MTBpve_RRpve_Internal,MTBpve_RRpve_External,Error_No_result_Invalid,Clinically_Diagnosed,Initiated_on_Antibiotic,Initiated_on_TBTx) 
SELECT  e.implementation_id, t.datetime_id , e.location_id,COALESCE(temp1.c1, 0 ),COALESCE(temp2.c1, 0 ),COALESCE(temp3.c1, 0 ),COALESCE(temp4.c1, 0 ),COALESCE(temp5.c1, 0 )
,COALESCE(temp6.c1, 0 ),COALESCE(temp7.c1, 0 ),COALESCE(temp8.c1, 0 ),COALESCE(temp8.c2, 0 ),COALESCE(temp8.c3, 0 ),COALESCE(temp8.c4, 0 ),
COALESCE(temp8.c5, 0 ),COALESCE(temp8.c6, 0 ),COALESCE(temp9.c1, 0 ),COALESCE(temp10.c1, 0 ),COALESCE(temp10.c2, 0 ),COALESCE(temp10.c3, 0 )

FROM encounter AS e 
INNER JOIN dim_datetime AS t ON t.full_date = DATE(e.date_created) 
left join (select count(*) as c1,t1.datetime_id,duf.location_id,duf.implementation_id  from gfatm_dw.uform_fast_screening duf 
inner JOIN dim_datetime AS t1 on t1.full_date = date(duf.date_entered) 
where t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,duf.location_id) temp1 on temp1.datetime_id=t.datetime_id and
temp1.location_id= e.location_id and temp1.implementation_id=1
left join (SELECT count(*) as c1,t1.datetime_id,cto.location_id,cto.implementation_id
 FROM gfatm_dw.enc_cxr_screening_test_order cto 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(cto.date_entered) 
 where reason_for_xray='screening' 
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,cto.location_id) temp2 on temp2.datetime_id=t.datetime_id and
temp2.location_id= e.location_id and temp2.implementation_id=1
left join ( SELECT count(*) as c1,t1.datetime_id,fp.location_id,fp.implementation_id 
 FROM  gfatm_dw.enc_fast_presumptive fp 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(fp.date_entered) 
 where  fp.presumptive_tb='yes' and fp.screening_type='symptom_screening' 
 
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,fp.location_id,fp.implementation_id) temp3 on temp3.datetime_id=t.datetime_id and
temp3.location_id= e.location_id and temp3.implementation_id=1
left join ( SELECT count(*) as c1,t1.datetime_id,ctr.location_id,ctr.implementation_id 
 FROM gfatm_dw.enc_cxr_screening_test_result ctr 
 inner join gfatm_dw.enc_cxr_screening_test_order cto on cto.patient_id=ctr.patient_id 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(cto.date_entered)  
 where ctr.presumptive_tb_cxr='yes' and cto.reason_for_xray='screening' 
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,ctr.location_id,ctr.implementation_id) temp4 on temp4.datetime_id=t.datetime_id and
temp4.location_id= e.location_id and temp4.implementation_id=1
left join (SELECT count(*) as c1,t1.datetime_id,fgsc.location_id,fgsc.implementation_id FROM gfatm_dw.enc_gxp_specimen_collection fgsc 
  inner join gfatm_dw.enc_fast_presumptive fp on fp.patient_id=fgsc.patient_id 
  inner JOIN dim_datetime AS t1 ON t1.full_date = date(fgsc.date_entered) 
  where fp.presumptive_tb='yes' and fp.screening_type='symptom_screening' 
  and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,fgsc.location_id,fgsc.implementation_id) temp5 on temp5.datetime_id=t.datetime_id and
temp5.location_id= e.location_id and temp5.implementation_id=1
left join (SELECT count(*) as c1,t1.datetime_id,fgsc.location_id,fgsc.implementation_id FROM gfatm_dw.enc_gxp_specimen_collection fgsc 
 inner join gfatm_dw.enc_cxr_screening_test_order cto on cto.patient_id=fgsc.patient_id
 inner join gfatm_dw.enc_cxr_screening_test_result ctr on ctr.patient_id=fgsc.patient_id 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(fgsc.date_entered) 
 where ctr.presumptive_tb_cxr='yes' and cto.reason_for_xray='screening'

 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,fgsc.location_id,fgsc.implementation_id) temp6 on temp6.datetime_id=t.datetime_id and
temp6.location_id= e.location_id and temp6.implementation_id=1
left join (SELECT count(*)as c1,t1.datetime_id,fgt.location_id,fgt.implementation_id FROM gfatm_dw.enc_genexpert_result fgt 
  inner JOIN dim_datetime AS t1 ON t1.full_date = date(fgt.date_entered) 
  where 
  t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,fgt.location_id,fgt.implementation_id) temp7 on temp7.datetime_id=t.datetime_id and
temp7.location_id= e.location_id and temp7.implementation_id=1
left join (SELECT SUM(IF(  fgt.location_id=fgsc.location_id and fgsc.sample_collected_from='within_site' , 1, 0))as c1,
  SUM(IF((fgt.location_id<>fgsc.location_id ) or (fgt.location_id=fgsc.location_id and fgsc.sample_collected_from='outside_site' ),1,0)) as c2,
  SUM(IF(  fgt.location_id=fgsc.location_id and fgsc.sample_collected_from='within_site' and fgt.gxp_result='detected', 1, 0))as c3,
  SUM(IF(((fgt.location_id<>fgsc.location_id ) or (fgt.location_id=fgsc.location_id and fgsc.sample_collected_from='outside_site' )) and fgt.gxp_result='detected',1,0)) as c4,
  SUM(IF(  fgt.location_id=fgsc.location_id and fgsc.sample_collected_from='within_site' and fgt.rif_result='detected', 1, 0))as c5,
  SUM(IF(((fgt.location_id<>fgsc.location_id ) or (fgt.location_id=fgsc.location_id and fgsc.sample_collected_from='outside_site' )) and fgt.rif_result='detected',1,0)) as c6,
  t1.datetime_id,fgt.location_id,fgt.implementation_id
  FROM gfatm_dw.enc_gxp_specimen_collection fgsc 
  inner join gfatm_dw.enc_genexpert_result fgt on fgt.patient_id=fgsc.patient_id 
  inner JOIN dim_datetime AS t1 ON t1.full_date = date(fgt.date_entered) 
  where  
t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,fgt.location_id,fgt.implementation_id) temp8 on temp8.datetime_id=t.datetime_id and
temp8.location_id= e.location_id and temp8.implementation_id=1
left join (SELECT count(distinct(fgt.patient_id))as c1,t1.datetime_id,fgt.location_id,fgt.implementation_id FROM gfatm_dw.enc_genexpert_result fgt 
inner JOIN dim_datetime AS t1 ON t1.full_date = date(fgt.date_entered)  
where (fgt.gxp_result='error' or fgt.gxp_result='no_result' or fgt.gxp_result='invalid') 

and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,fgt.location_id,fgt.implementation_id) temp9 on temp9.datetime_id=t.datetime_id and
temp9.location_id= e.location_id and temp9.implementation_id=1
left join (
SELECT SUM(IF( diagnosis_type='clinical_suspicion' or diagnosis_type='CLINICAL SUSPICION' , 1, 0)) as c1,
SUM(IF(antibiotic='yes', 1, 0)) as c2,
SUM(IF(treatment_initiated='yes', 1, 0)) as c3,
t1.datetime_id,fti.location_id,fti.implementation_id 
FROM gfatm_dw.enc_fast_treatment_initiation fti 
inner JOIN dim_datetime AS t1 ON t1.full_date = date(fti.date_entered) 
where  t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,fti.location_id,fti.implementation_id) temp10 on temp10.datetime_id=t.datetime_id and
temp10.location_id= e.location_id and temp10.implementation_id=1

where e.encounter_type in (18,19,20,22,23,29,30) and t.full_date >=(current_date()-interval 1 month) and e.location_id is not null 
group by e.implementation_id, t.datetime_id,e.location_id;


RESET QUERY CACHE;
delete from gfatm_dw.fact_childtb_dsss where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));

insert into gfatm_dw.fact_childtb_dsss (implementation_id,datetime_id,location_id,Screened_nurse,Presumptive_nurse,clinician_evaluation,Presumptive_Case_Confirmed,Test_indication,CBC_Indicated,ESR_Indicated,CXR_Indicated,
MT_Indicated,Ultrasound_Indicated,HistopathologyFNAC_Indicated,CT_scan_Indicated,GXP_Indicated,TB_Treatment_intiated,Antibiotic_trial_initiated,IPT_treatment_initiated,TB_Treatment_Follow_up,Antibiotic_trial_Followup,IPT_follow_up,End_of_followup)
SELECT fe.implementation_id,fe.datetime_id,fe.location_id,
COALESCE(temp1.c1, 0 ),COALESCE(temp1.c2, 0 ),COALESCE(temp2.c1, 0 ),COALESCE(temp2.c2, 0 ),COALESCE(temp3.c1, 0 ),
COALESCE(temp3.c2, 0 ),COALESCE(temp3.c3, 0 ),COALESCE(temp4.c1, 0 ),COALESCE(temp3.c4, 0 ),COALESCE(temp5.c1, 0 ),
COALESCE(temp6.c1, 0 ),COALESCE(temp3.c5, 0 ),COALESCE(temp7.c1, 0 ),COALESCE(temp8.c1, 0 ),COALESCE(temp9.c1, 0 ),
COALESCE(temp10.c1, 0 ),COALESCE(temp11.c1, 0 ),COALESCE(temp12.c1, 0 ),COALESCE(temp13.c1, 0 ),COALESCE(temp14.c1, 0 )     

FROM gfatm_dw.fact_encounter fe
left join(SELECT count(*) as c1,SUM(IF( ctvs.presumptive_tb='yes' , 1, 0)) as c2,t1.datetime_id,ctvs.location_id,ctvs.implementation_id FROM gfatm_dw.enc_childhood_tb_verbal_screening ctvs 
inner JOIN dim_datetime AS t1 ON t1.full_date = date(ctvs.date_entered) 
where 
 t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,ctvs.location_id,ctvs.implementation_id) as temp1 on temp1.datetime_id=fe.datetime_id and
temp1.location_id= fe.location_id and temp1.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,SUM(IF( ctpcc.conclusion_presumptive='tb_presumptive_confirmed' , 1, 0)) as c2,t1.datetime_id,ctpcc.location_id,ctpcc.implementation_id 
 FROM gfatm_dw.enc_clinician_evaluation ctpcc 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(ctpcc.date_entered) 
 inner join dim_patient as dp on dp.patient_id=ctpcc.patient_id 
 where (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
 and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15  
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,ctpcc.location_id,ctpcc.implementation_id) as temp2 on temp2.datetime_id=fe.datetime_id and
temp2.location_id= fe.location_id and temp2.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,SUM(IF( ctti.refer_cbc='yes' , 1, 0)) as c2, SUM(IF( ctti.refer_esr='yes', 1, 0)) as c3, 
 SUM(IF( ctti.refer_mantoux_test='yes' , 1, 0)) as c4,SUM(IF( ctti.refer_ct_scan='yes' , 1, 0)) as c5,
 t1.datetime_id,ctti.location_id,ctti.implementation_id
 FROM gfatm_dw.enc_childhood_tb_test_indication ctti 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(ctti.date_entered) 
 where  t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,ctti.location_id,ctti.implementation_id) as temp3 on temp3.datetime_id=fe.datetime_id and
temp3.location_id= fe.location_id and temp3.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,csto.location_id,csto.implementation_id FROM gfatm_dw.enc_cxr_screening_test_order csto 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(csto.date_entered) 
 inner join dim_patient as dp on dp.patient_id=csto.patient_id 
 inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=csto.patient_id 
 where (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
 and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15 
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,csto.location_id,csto.implementation_id) as temp4 on temp4.datetime_id=fe.datetime_id and
temp4.location_id= fe.location_id and temp4.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,uto.location_id,uto.implementation_id
FROM gfatm_dw.enc_ultrasound_test_order uto 
inner JOIN dim_datetime AS t1 ON t1.full_date = date(uto.date_entered) 
inner join dim_patient as dp on dp.patient_id=uto.patient_id 
inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=uto.patient_id 
where (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15 

and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,uto.location_id,uto.implementation_id) as temp5 on temp5.datetime_id=fe.datetime_id and
temp5.location_id= fe.location_id and temp5.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,hto.location_id,hto.implementation_id
 FROM gfatm_dw.enc_histopathology_test_order hto 
inner JOIN dim_datetime AS t1 ON t1.full_date = date(hto.date_entered) 
inner join dim_patient as dp on dp.patient_id=hto.patient_id 
inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=hto.patient_id 
where (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15 

and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,hto.location_id,hto.implementation_id) as temp6 on temp6.datetime_id=fe.datetime_id and
temp6.location_id= fe.location_id and temp6.implementation_id=fe.implementation_id
left join( SELECT count(*) as c1,t1.datetime_id,gsc.location_id,gsc.implementation_id FROM gfatm_dw.enc_gxp_specimen_collection gsc 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(gsc.date_entered) 
 inner join dim_patient as dp on dp.patient_id=gsc.patient_id 
 inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=gsc.patient_id 
 where (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
 and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15 
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,gsc.location_id,gsc.implementation_id) as temp7 on temp7.datetime_id=fe.datetime_id and
temp7.location_id= fe.location_id and temp7.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,ctti.location_id,ctti.implementation_id FROM gfatm_dw.enc_childhood_tb_tb_treatment_initiation ctti 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(ctti.date_entered) 
 where ctti.treatment_initiated='yes' 

 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,ctti.location_id,ctti.implementation_id
 ) as temp8 on temp8.datetime_id=fe.datetime_id and
temp8.location_id= fe.location_id and temp8.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,ati.location_id,ati.implementation_id
 FROM gfatm_dw.enc_childhood_tb_antibiotic_trial_initiation ati 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(ati.date_entered) 
 inner join dim_patient as dp on dp.patient_id=ati.patient_id 
 inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=ati.patient_id 
 where ati.antibiotic='yes' and (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
 and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15 
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,ati.location_id,ati.implementation_id) as temp9 on temp9.datetime_id=fe.datetime_id and
temp9.location_id= fe.location_id and temp9.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,pti.location_id,pti.implementation_id
 FROM gfatm_dw.enc_pet_treatment_initiation pti 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(pti.date_entered) 
 inner join dim_patient as dp on dp.patient_id=pti.patient_id 
 inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=pti.patient_id 
 where pti.ipt_start_date is not null 
 and (ctpcc.patient_source='screening' or ctpcc.patient_source='referral'or ctpcc.patient_source='walk_in' ) 
 and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15  
and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,pti.location_id,pti.implementation_id) as temp10 on temp10.datetime_id=fe.datetime_id and
temp10.location_id= fe.location_id and temp10.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,cttf.location_id,cttf.implementation_id
 FROM gfatm_dw.enc_childhood_tb_tb_treatment_followup cttf 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(cttf.date_entered) 
 where 
 t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,cttf.location_id,cttf.implementation_id) as temp11 on temp11.datetime_id=fe.datetime_id and
temp11.location_id= fe.location_id and temp11.implementation_id=fe.implementation_id
left join( SELECT count(*) as c1,t1.datetime_id,atf.location_id,atf.implementation_id
 FROM gfatm_dw.enc_childhood_tb_antibiotic_trial_followup atf 
 inner JOIN dim_datetime AS t1 ON t1.full_date = date(atf.date_entered) 
 inner join dim_patient as dp on dp.patient_id=atf.patient_id 
 inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=atf.patient_id 
 where (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
 and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15 
 and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,atf.location_id,atf.implementation_id) as temp12 on temp12.datetime_id=fe.datetime_id and
temp12.location_id= fe.location_id and temp12.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,ctif.location_id,ctif.implementation_id
FROM gfatm_dw.enc_childhood_tb_ipt_followup ctif 
inner JOIN dim_datetime AS t1 ON t1.full_date = date(ctif.date_entered) 
where  
 t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,ctif.location_id,ctif.implementation_id) as temp13 on temp13.datetime_id=fe.datetime_id and
temp13.location_id= fe.location_id and temp13.implementation_id=fe.implementation_id
left join(SELECT count(*) as c1,t1.datetime_id,eof.location_id,eof.implementation_id
FROM gfatm_dw.enc_end_of_followup eof 
inner JOIN dim_datetime AS t1 ON t1.full_date = date(eof.date_entered) 
inner join dim_patient as dp on dp.patient_id=eof.patient_id 
inner join gfatm_dw.enc_clinician_evaluation ctpcc on ctpcc.patient_id=eof.patient_id 
where (patient_source='screening' or patient_source='referral'or patient_source='walk_in' ) 
and (YEAR(dp.date_created) - YEAR(dp.birthdate))<15   
and t1.full_date >=(current_date()-interval 1 month) group by t1.datetime_id,eof.location_id,eof.implementation_id
 ) as temp14 on temp14.datetime_id=fe.datetime_id and
temp14.location_id= fe.location_id and temp14.implementation_id=fe.implementation_id
where encounter_type in(55,58, 59, 61, 82, 70,  64, 85, 60, 81, 71,55, 62, 83, 74, 66, 87, 69, 65, 86, 73, 53, 56, 54, 72, 52, 160, 68, 57, 67, 63, 84, 51) 
and fe.location_id is not null 
and fe.datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) 
group by fe.datetime_id,fe.location_id;

RESET QUERY CACHE;
delete from gfatm_dw.fact_Pet_DS where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));

insert into gfatm_dw.fact_Pet_DS(implementation_id,datetime_id,location_id,No_Of_Index_Patients_Registered,No_Of_DSTB_Patients,
    No_Of_DRTB_Patients,
    No_Of_Baseline_Screening,
    No_Of_Index_Patient_Agreed_For_Their_Contact_Screening,
    No_Of_Adult_Contacts,
    No_Of_Peads_Contacts,
    No_Of_Index_Not_Eligible_For_Study,
    No_Of_Contact_Screening_Counseling_Done,
    No_Of_Baseline_Counceling_Done,
    No_Of_Contacts_Investigated,
    No_Of_Contacts_Diagnosed_With_TB,
    No_Of_Contacts_Eligible_For_Pet,
    No_Of_Contacts_Agreed_For_Pet,
    No_Of_Contacts_Completed_Treatment)(
select   fe.implementation_id,fe.datetime_id,fe.location_id, 
COALESCE(temp1.c1, 0 ), COALESCE(temp1.c2, 0 ), COALESCE(temp1.c3, 0 ),COALESCE(temp2.c1, 0 ), COALESCE(temp3.c1, 0 ),
COALESCE(temp3.c3, 0 ),COALESCE(temp3.c2, 0 ),COALESCE(temp4.c1, 0 ),COALESCE(temp5.c1, 0 ),COALESCE(temp6.c1, 0 ),
COALESCE(temp7.c1, 0 ),COALESCE(temp8.c1, 0 ), COALESCE(temp8.c2, 0 ), COALESCE(temp8.c3, 0 ),COALESCE(temp4.c2, 0 )
from gfatm_dw.fact_encounter fe
left join(select count(*) as c1,SUM(IF( tb_infection_type='DS-TB' , 1, 0)) as c2, 
SUM(IF( tb_infection_type='DR-TB' , 1, 0)) as c3,
d.datetime_id,p.location_id,p.implementation_id from 
gfatm_dw.enc_pet_index_patient_registration p 
inner join dim_datetime as d on d.full_date= date(p.date_entered) 
where 
d.full_date>=(current_date()-interval 1 month) group by d.datetime_id,p.location_id,p.implementation_id) as temp1 on temp1.datetime_id=fe.datetime_id and
temp1.location_id= fe.location_id and temp1.implementation_id=fe.implementation_id
left join( select count(*) as c1,d.datetime_id,b.location_id,b.implementation_id
from gfatm_dw.enc_pet_baseline_screening b 
inner join dim_datetime as d on d.full_date= date(b.date_entered) 
where 

 d.full_date>=(current_date()-interval 1 month) group by d.datetime_id,b.location_id,b.implementation_id)as temp2 on temp2.datetime_id=fe.datetime_id and
temp2.location_id= fe.location_id and temp2.implementation_id=fe.implementation_id
left join(SELECT SUM(IF( consent_for_contact_investigation='yes'  , 1, 0)) as c1,sum(childhood_contacts) as c2,sum(adult_contacts) as c3,d.datetime_id,r.location_id,r.implementation_id FROM gfatm_dw.enc_contact_registry r 
inner join dim_datetime as d on d.full_date= date(r.date_entered) 
where  d.full_date>=(current_date()-interval 1 month) group by d.datetime_id,r.location_id,r.implementation_id )as temp3 on temp3.datetime_id=fe.datetime_id and
temp3.location_id= fe.location_id and temp3.implementation_id=fe.implementation_id
left join(select SUM(IF( treatment_outcome='not_eligible_for_program', 1, 0)) as c1,SUM(IF( treatment_outcome='treatment_complete', 1, 0)) as c2 ,d.datetime_id,f.location_id,f.implementation_id 
from gfatm_dw.enc_end_of_followup f  
inner join dim_datetime as d on d.full_date= date(f.date_entered) 
where 
 d.full_date>=(current_date()-interval 1 month) group by d.datetime_id,f.location_id,f.implementation_id )as temp4 on temp4.datetime_id=fe.datetime_id and
temp4.location_id= fe.location_id and temp4.implementation_id=fe.implementation_id
left join(select count(*) as c1, d.datetime_id,s.location_id,s.implementation_id
from gfatm_dw.enc_pet_socioeconomic_data s 
inner join dim_datetime as d on d.full_date= date(s.date_entered) 
where  d.full_date>=(current_date()-interval 1 month) group by d.datetime_id,s.location_id,s.implementation_id )as temp5 on temp5.datetime_id=fe.datetime_id and
temp5.location_id= fe.location_id and temp5.implementation_id=fe.implementation_id
left join(select count(*) as c1,d.datetime_id,c.location_id,c.implementation_id from gfatm_dw.enc_pet_baseline_counselling c  
inner join dim_datetime as d on d.full_date= date(c.date_entered) 
where   
d.full_date>=(current_date()-interval 1 month)  group by d.datetime_id,c.location_id,c.implementation_id )as temp6 on temp6.datetime_id=fe.datetime_id and
temp6.location_id= fe.location_id and temp6.implementation_id=fe.implementation_id
left join(select count(*) as c1, d.datetime_id,tr.location_id,tr.implementation_id
from gfatm_dw.enc_cxr_screening_test_result tr 
inner join dim_datetime as d on d.full_date= date(tr.date_entered) 
where   d.full_date>=(current_date()-interval 1 month)  group by d.datetime_id,tr.location_id,tr.implementation_id )as temp7 on temp7.datetime_id=fe.datetime_id and
temp7.location_id= fe.location_id and temp7.implementation_id=fe.implementation_id
left join(select SUM(IF( tb_diagnosis='yes'  , 1, 0)) as c1,SUM(IF( pet_eligible='yes'  , 1, 0)) as c2,SUM(IF( pet_consent='yes'  , 1, 0)) as c3, d.datetime_id,e.location_id,e.implementation_id
from gfatm_dw.enc_pet_infection_treatment_eligibility e 
inner join dim_datetime as d on d.full_date= date(e.date_entered) 
where  d.full_date>=(current_date()-interval 1 month)  group by d.datetime_id,e.location_id,e.implementation_id
 )as temp8 on temp8.datetime_id=fe.datetime_id and
temp8.location_id= fe.location_id and temp8.implementation_id=fe.implementation_id

where  encounter_type IN( 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,131,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,157,158,159) and fe.location_id is not null and fe.datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) group by  fe.datetime_id, fe.location_id );


RESET QUERY CACHE;
delete from gfatm_dw.fact_patient_source where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
insert into gfatm_dw.fact_patient_source (implementation_id,datetime_id,location_id,screening,walk_in,tb_contact,referral,other_patient_source)(select pi.implementation_id,datetime_id,pi.location_id, SUM(IF(if(pi.patient_source is not null,pi.patient_source,ce.patient_source)='screening', 1, 0))  as screening, SUM(IF(if(pi.patient_source is not null,pi.patient_source,ce.patient_source)='walk_in', 1, 0)) as walk_in, SUM(IF(if(pi.patient_source is not null,pi.patient_source,ce.patient_source)='tb_contact', 1, 0)) as tb_contact, SUM(IF(if(pi.patient_source is not null,pi.patient_source,ce.patient_source)='referral', 1, 0)) as referral, SUM(IF(if(pi.patient_source is not null,pi.patient_source,ce.patient_source)='other_patient_source', 1, 0))  as other_patient_source from enc_patient_information pi inner join  dim_datetime as d on d.full_date= date(pi.date_entered) inner join enc_childhood_tb_tb_treatment_initiation ti on ti.patient_id=pi.patient_id left join enc_clinician_evaluation ce on ce.patient_id=pi.patient_id where datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) GROUP BY pi.implementation_id, d.datetime_id,pi.location_id);

delete from gfatm_dw.fact_chtb_treatment_initiation where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
insert into gfatm_dw.fact_chtb_treatment_initiation (implementation_id,datetime_id,location_id,tb_patient,male_lessthan_1,male_1_to_4,male_5_to_9,male_10_to_15,female_lessthan_1,female_1_to_4,female_5_to_9,female_10_to_15,bacteriologically_confirmed,clinical_suspicion,pulmonary_tb,extrapulmonary_tb,tb_type_both,patient_type_new,patient_type_relapse,tb_category_cat_1,tb_category_cat_2,tb_category_cat_3,treatment_initiated_yes,treatment_initiated_no)(select ti.implementation_id,datetime_id,ti.location_id, SUM(IF(tb_patient='yes', 1, 0)) AS tb_patient, SUM(IF(gender='m' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)<1), 1, 0)) AS male_lessthan_1, SUM(IF(gender='m' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)between 1 and 4), 1, 0)) AS male_1_to_4, SUM(IF(gender='m' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)between 5 and 9), 1, 0)) AS male_5_to_9, SUM(IF(gender='m' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)between 10 and 15), 1, 0)) AS male_10_to_15, SUM(IF(gender='f' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)<1), 1, 0)) AS female_lessthan_1, SUM(IF(gender='f' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)between 1 and 4), 1, 0)) AS female_1_to_4, SUM(IF(gender='f' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)between 5 and 9), 1, 0)) AS female_5_to_9, SUM(IF(gender='f' and (YEAR(ti.date_entered) - YEAR(PT.birthdate)between 10 and 15), 1, 0)) AS female_10_to_15, SUM(IF(diagnosis_type like'%bacteriologically_confirmed%', 1, 0)) AS bacteriologically_confirmed, SUM(IF(diagnosis_type like '%clinical_suspicion%', 1, 0)) AS clinical_suspicion, SUM(IF(tb_type='pulmonary_tb', 1, 0)) AS pulmonary_tb, SUM(IF(tb_type='extrapulmonary_tb', 1, 0)) AS extrapulmonary_tb, SUM(IF(tb_type='both', 1, 0)) AS tb_type_both, SUM(IF(ti.patient_type='NEW', 1, 0)) AS patient_type_new, SUM(IF(ti.patient_type='relapse', 1, 0)) AS patient_type_relapse, SUM(IF(tb_category='cat_1', 1, 0)) AS tb_category_cat_1, SUM(IF(tb_category='cat_2_tb', 1, 0)) AS tb_category_cat_2, SUM(IF(tb_category='cat_3_tb', 1, 0)) AS tb_category_cat_3, SUM(IF(treatment_initiated='yes', 1, 0)) AS treatment_initiated_yes, SUM(IF(treatment_initiated='no', 1, 0)) AS treatment_initiated_no FROM gfatm_dw.enc_childhood_tb_tb_treatment_initiation ti inner join  dim_datetime as d on d.full_date= date(ti.date_entered) inner JOIN dim_patient AS PT ON PT.patient_id=ti.patient_id where datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) GROUP BY ti.implementation_id, d.datetime_id,ti.location_id);

delete from gfatm_dw.fact_end_of_followup where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
insert into gfatm_dw.fact_end_of_followup (implementation_id,datetime_id,location_id,CURE,treatment_complete,tb_treatment_failure,died,transferred_out,referral,lost_to_followup)( SELECT eof.implementation_id,datetime_id,eof.location_id, SUM(IF(treatment_outcome='CURE', 1, 0)) AS CURE, SUM(IF(treatment_outcome='treatment_complete', 1, 0)) AS treatment_complete, SUM(IF(treatment_outcome='tb_treatment_failure', 1, 0)) AS tb_treatment_failure, SUM(IF(treatment_outcome='died', 1, 0)) AS died, SUM(IF(treatment_outcome='transferred_out', 1, 0)) AS transferred_out, SUM(IF(treatment_outcome='referral', 1, 0)) AS referral, SUM(IF(treatment_outcome='DEFAULT', 1, 0)) AS lost_to_followup from enc_end_of_followup eof inner join enc_childhood_tb_tb_treatment_initiation ti on ti.patient_id=eof.patient_id inner join  dim_datetime as d on d.full_date= date(eof.date_entered) where datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) GROUP BY eof.implementation_id, d.datetime_id,eof.location_id);

delete from gfatm_dw.fact_childtb_sd where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));

insert into fact_childtb_sd (implementation_id,datetime_id,location_id,symptom_screened_nurse,presumptive_nurse,presumptive_MO,diagnosed_patients,treatment_started)
SELECT fe.implementation_id,fe.datetime_id,fe.location_id, 
COALESCE(temp1.c1, 0 ), COALESCE(temp1.c2, 0 ),COALESCE(temp2.c1, 0 ), COALESCE(temp3.c1, 0 ),
COALESCE(temp3.c2, 0 )
FROM gfatm_dw.fact_encounter fe
left join(select count(*) as c1,SUM(IF( presumptive_tb='yes'  , 1, 0)) as c2,dt.datetime_id,vs_1.location_id,vs_1.implementation_id
from enc_childhood_tb_verbal_screening vs_1 
inner join dim_datetime dt ON dt.full_date = DATE(vs_1.date_entered) 
where 
 dt.full_date >=(current_date()-interval 1 month) group by dt.datetime_id,vs_1.location_id,vs_1.implementation_id) as temp1 on temp1.datetime_id=fe.datetime_id and
temp1.location_id= fe.location_id and temp1.implementation_id=fe.implementation_id
left join(select count(*) as c1,dt.datetime_id,pcc.location_id,pcc.implementation_id
from enc_clinician_evaluation pcc 
inner join dim_datetime dt ON dt.full_date = DATE(pcc.date_entered) 
where conclusion_presumptive='tb_presumptive_confirmed' 
and dt.full_date >=(current_date()-interval 1 month) group by dt.datetime_id,pcc.location_id,pcc.implementation_id) as temp2 on temp2.datetime_id=fe.datetime_id and
temp2.location_id= fe.location_id and temp2.implementation_id=fe.implementation_id
left join(select SUM(IF( tb_patient='yes'   , 1, 0)) as c1,SUM(IF( treatment_initiated='yes' , 1, 0)) as c2,dt.datetime_id,ti_1.location_id,ti_1.implementation_id
from enc_childhood_tb_tb_treatment_initiation ti_1 
inner join dim_datetime dt ON dt.full_date = DATE(ti_1.date_entered) 
where dt.full_date >=(current_date()-interval 1 month) group by dt.datetime_id,ti_1.location_id,ti_1.implementation_id) as temp3 on temp3.datetime_id=fe.datetime_id and
temp3.location_id= fe.location_id and temp3.implementation_id=fe.implementation_id

where fe.encounter_type in(61, 82, 70, 55, 64, 85, 60, 81, 71, 62, 83, 74, 58, 59, 66, 87, 69, 65, 86, 73, 53, 56, 54, 72, 52, 160, 68, 57, 67, 63, 84, 51) and fe.location_id is not null and fe.datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) group by fe.datetime_id,fe.location_id;


update fact_childtb_sd fcsd set percent_presumptive_TB_nurse=((presumptive_nurse/symptom_screened_nurse)*100) where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update fact_childtb_sd fcsd set percent_presumptive_MO=((presumptive_MO/presumptive_nurse)*100) where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update fact_childtb_sd fcsd set percent_diagnosed_patients=((diagnosed_patients/presumptive_MO)*100) where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update fact_childtb_sd fcsd set percent_treatment_started=((diagnosed_patients/treatment_started)*100) where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update fact_childtb_sd fcsd set yield=(select(diagnosed_patients/presumptive_nurse)*100) where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));


RESET QUERY CACHE;
delete from gfatm_dw.fact_comorb_mhfup_dw where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));

insert into gfatm_dw.fact_comorb_mhfup_dw (datetime_id,implementation_id,location_id)(select  datetime_id, implementation_id,  location_id from gfatm_dw.fact_encounter  where  encounter_type IN(48,36,77,34,155,40,75,44,46,45,43,38,50,49,35,76,41,79,16,156,33,47,39,78,42,80,37) and datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) group by  datetime_id, location_id  order by location_id ASC);

update gfatm_dw.fact_comorb_mhfup_dw  mhfup set Number_Of_Anticipated_Visits=((select count(*) from gfatm_dw.enc_comorbidities_mental_health_screening s left join gfatm_dw.enc_comorbidities_treatment_followup_mental_health f on s.patient_id=f.patient_id inner join  dim_datetime as d on d.full_date= date(s.return_visit_date) where f.patient_id is null and s.date_entered=(select max(date_entered) from  gfatm_dw.enc_comorbidities_mental_health_screening where patient_id=s.patient_id) and  d.datetime_id= mhfup.datetime_id and s.location_id= mhfup.location_id and s.implementation_id= mhfup.implementation_id and d.full_date >= (current_date()-interval 1 month)) + (select count(*) from gfatm_dw.enc_comorbidities_treatment_followup_mental_health f inner join  dim_datetime as d on d.full_date= date(f.return_visit_date) where f.date_entered=(select max(date_entered)  from  gfatm_dw.enc_comorbidities_treatment_followup_mental_health where patient_id=f.patient_id) and  d.datetime_id= mhfup.datetime_id and f.location_id= mhfup.location_id and f.implementation_id= mhfup.implementation_id and d.full_date >= (current_date()-interval 1 month)) ) where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));  
update gfatm_dw.fact_comorb_mhfup_dw  mhfup set Number_Of_Visits_Done= (select count(*) from gfatm_dw.enc_comorbidities_treatment_followup_mental_health f inner join   dim_datetime as d on d.full_date= date(f.date_entered) where d.datetime_id= mhfup.datetime_id and f.location_id= mhfup.location_id and f.implementation_id= mhfup.implementation_id and d.full_date >= (current_date()-interval 1 month))  where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_comorb_mhfup_dw  mhfup set Number_Of_Assessment_Form_MH=(select count(*) from gfatm_dw.enc_comorbidities_assessment_form_mental_health h inner join   dim_datetime as d on d.full_date= date(h.date_entered) where d.datetime_id= mhfup.datetime_id and h.location_id= mhfup.location_id and h.implementation_id= mhfup.implementation_id and d.full_date >= (current_date()-interval 1 month))  where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)); 
update gfatm_dw.fact_comorb_mhfup_dw  mhfup set Number_of_End_Of_Treatment_MH=(select count(*) from gfatm_dw.enc_comorbidities_end_of_treatment_mental_health t inner join dim_datetime as d on d.full_date= date(t.date_entered) where d.datetime_id=mhfup.datetime_id and t.location_id= mhfup.location_id and t.implementation_id= mhfup.implementation_id and d.full_date >= (current_date()-interval 1 month))  where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)); 
RESET QUERY CACHE;
delete from gfatm_dw.fact_chtb_ltf_antibiotic_treatment where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));

insert into gfatm_dw.fact_chtb_ltf_antibiotic_treatment (datetime_id,implementation_id,location_id,Antibiotic_patients,
Missed_Antibiotic_Treatment,
Refused_Antibiotics,
On_Antibioitc_Treatment,
End_of_Antibiotic_Treatment,
TB_Diagnosed,
TB_Treatment_Initiated

)
( select  fe.datetime_id, fe.implementation_id,  fe.location_id,
COALESCE(temp1.c1, 0 ), COALESCE(temp2.c1, 0 ), COALESCE(temp3.c1, 0 ),COALESCE(temp3.c2, 0 ), COALESCE(temp4.c1, 0 ),
COALESCE(temp5.c1, 0 ),COALESCE(temp5.c2, 0 ) 
from gfatm_dw.fact_encounter fe 
left join(select count(*) as c1,
d.datetime_id,t.location_id,t.implementation_id  from 
gfatm_dw.enc_childhood_tb_antibiotic_trial_initiation t 
inner join dim_datetime  as d on d.full_date = date(t.date_entered) 
where tb_patient='inconclusive'  
 
and d.full_date >=(current_date()-interval 1 month) group by d.datetime_id,t.location_id,t.implementation_id) as temp1 on temp1.datetime_id=fe.datetime_id and
temp1.location_id= fe.location_id and temp1.implementation_id=fe.implementation_id
left join(select count(*) as c1,
d.datetime_id,t.location_id,t.implementation_id  from 
  gfatm_dw.enc_childhood_tb_antibiotic_trial_initiation t 
inner join  gfatm_dw.enc_childhood_tb_tb_treatment_initiation t1 on t.patient_id=t1.patient_id and t1.encounter_id=(select encounter_id from gfatm_dw.enc_childhood_tb_tb_treatment_initiation where patient_id=t1.patient_id order by encounter_id limit 1,1) 
left join gfatm_dw.enc_end_of_followup f on t.patient_id=f.patient_id and t.date_entered=(select min(date_entered) from gfatm_dw.enc_childhood_tb_tb_treatment_initiation where patient_id=t.patient_id) 
left join gfatm_dw.enc_childhood_tb_antibiotic_trial_followup a on t1.patient_id= a.patient_id and a.date_entered=(select max(date_entered) from gfatm_dw.enc_childhood_tb_antibiotic_trial_followup where patient_id=a.patient_id) 
inner join dim_datetime  as d on d.full_date = date(t.date_entered)
 where (t.tb_patient='inconclusive' ) and not(t1.tb_patient='yes') and t.antibiotic= 'yes' and (((f.patient_id is null) 
 and (curdate()> date(t.date_entered) + interval 2 week)) and  ((f.patient_id is null) 
 and (curdate()> date(a.date_entered) + interval 2 week) )) 

 and d.full_date >=(current_date()-interval 1 month) and t.encounter_id=(select encounter_id from gfatm_dw.enc_childhood_tb_tb_treatment_initiation where patient_id=t.patient_id order by encounter_id limit 0,1 ) group by d.datetime_id,t.location_id,t.implementation_id) as temp2 on temp2.datetime_id=fe.datetime_id and
temp2.location_id= fe.location_id and temp2.implementation_id=fe.implementation_id
left join(SELECT SUM(IF( antibiotic= 'no'   , 1, 0)) as c1, SUM(IF( antibiotic= 'yes'   , 1, 0)) as c2 ,d.datetime_id,t.location_id,t.implementation_id from
gfatm_dw.enc_childhood_tb_antibiotic_trial_initiation t 
inner join dim_datetime  as d on d.full_date = date(t.date_entered) 
where (tb_patient='inconclusive' )  
and d.full_date >=(current_date()-interval 1 month) group by d.datetime_id,t.location_id,t.implementation_id )as temp3 on temp3.datetime_id=fe.datetime_id and
temp3.location_id= fe.location_id and temp3.implementation_id=fe.implementation_id
left join(select count(*) as c1,
d.datetime_id,t.location_id,t.implementation_id from gfatm_dw.enc_childhood_tb_antibiotic_trial_initiation t 
inner  join gfatm_dw.enc_end_of_followup f on t.patient_id=f.patient_id 
inner join dim_datetime  as d on d.full_date = date(t.date_entered) 
where t.tb_patient='inconclusive' and f.treatment_outcome='antibiotic_complete_no_tb' 

and d.full_date >=(current_date()-interval 1 month) group by d.datetime_id,t.location_id,t.implementation_id)as temp4 on temp4.datetime_id=fe.datetime_id and
temp4.location_id= fe.location_id and temp4.implementation_id=fe.implementation_id
left join(select count(*) as c1,SUM(IF( t1.treatment_initiated='yes', 1, 0)) as c2,
d.datetime_id,t.location_id,t.implementation_id 
from gfatm_dw.enc_childhood_tb_tb_treatment_initiation t 
inner join gfatm_dw.enc_childhood_tb_tb_treatment_initiation t1 on t.patient_id=t1.patient_id and t1.encounter_id=(select encounter_id from gfatm_dw.enc_childhood_tb_tb_treatment_initiation where patient_id=t1.patient_id order by encounter_id limit 1,1) 
inner join  dim_datetime  as d on d.full_date = date(t.date_entered) 
where t.tb_patient='inconclusive' and t1.tb_patient='yes'   
and d.full_date >=(current_date()-interval 1 month) and t.encounter_id=(select encounter_id from gfatm_dw.enc_childhood_tb_tb_treatment_initiation where patient_id=t.patient_id order by encounter_id limit 0,1) group by d.datetime_id,t.location_id,t.implementation_id  )as temp5 on temp5.datetime_id=fe.datetime_id and
temp5.location_id= fe.location_id and temp5.implementation_id=fe.implementation_id

where  fe.encounter_type IN(51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,81,82,83,84,85,86,87,160,210,211) and fe.location_id is not null and fe.datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) group by  fe.datetime_id, fe.location_id );

update gfatm_dw.fact_chtb_ltf_antibiotic_treatment atm set Percentage_Missed_Antibiotic_Treatment=(Missed_Antibiotic_Treatment/Antibiotic_patients) *100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_antibiotic_treatment atm set Percentage_Refused_Antibiotics=(Refused_Antibiotics/Antibiotic_patients)*100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_antibiotic_treatment atm set Percentage_On_Antibioitic_Treatment=( On_Antibioitc_Treatment/Antibiotic_patients )*100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_antibiotic_treatment atm set Percentage_End_of_Antibiotic_Treatment=(End_of_Antibiotic_Treatment/Antibiotic_patients)*100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_antibiotic_treatment atm set percentage_tb_diagnosed=(TB_Diagnosed/On_Antibioitc_Treatment)*100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_antibiotic_treatment atm set Percentage_TB_Treatment_Initiated =(TB_Treatment_Initiated/TB_Diagnosed)*100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));


RESET QUERY CACHE;
delete from gfatm_dw.fact_chtb_ltf_clinical_evaluation where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));


insert into gfatm_dw.fact_chtb_ltf_clinical_evaluation (datetime_id,implementation_id,location_id,
    Total_Presumptives_By_Nurse,
    MO_Evaluation,
    Presumptives_Missing_Clinical_Evaluation,
    Tb_Presumptive_Confirmed,
    Not_Tb_Presumptive
)
( select  fe.datetime_id, fe.implementation_id,  fe.location_id,
COALESCE(temp1.c1, 0 ), COALESCE(temp2.c1, 0 ), COALESCE(temp2.c2, 0 ),COALESCE(temp2.c3, 0 ), COALESCE(temp2.c4, 0 )
from gfatm_dw.fact_encounter fe 
left join(select count(*) as c1,
d.datetime_id,v.location_id,v.implementation_id 
from gfatm_dw.enc_childhood_tb_verbal_screening v 
inner join  dim_datetime as d on d.full_date = date(v.date_entered) 
where presumptive_tb='yes'  
and d.full_date >=(current_date()-interval 1 month) group by d.datetime_id,v.location_id,v.implementation_id) as temp1 on temp1.datetime_id=fe.datetime_id and
temp1.location_id= fe.location_id and temp1.implementation_id=fe.implementation_id
left join(select SUM(IF( p.patient_id is not null, 1, 0)) as c1,SUM(IF( p.patient_id is null, 1, 0)) as c2,SUM(IF( p.patient_id is not null and conclusion_presumptive='tb_presumptive_confirmed', 1, 0)) as c3,SUM(IF( p.patient_id is not null and child_diagnosed_presumptive_by_mo='no', 1, 0)) as c4,
d.datetime_id,v.location_id,v.implementation_id 
from  gfatm_dw.enc_childhood_tb_verbal_screening v 
left join gfatm_dw.enc_clinician_evaluation p on p.patient_id=v.patient_id  
inner join dim_datetime as d on d.full_date = date(v.date_entered) 
where v.presumptive_tb='yes' 
and d.full_date >=(current_date()-interval 1 month) group by d.datetime_id,v.location_id,v.implementation_id) as temp2 on temp2.datetime_id=fe.datetime_id and
temp2.location_id= fe.location_id and temp2.implementation_id=fe.implementation_id

where  fe.encounter_type IN(51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,81,82,83,84,85,86,87,160,210,211) and fe.location_id is not null and fe.datetime_id>=(select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month)) group by  fe.datetime_id, fe.location_id );




update gfatm_dw.fact_chtb_ltf_clinical_evaluation ltfce set Percentage_MO_Evaluation=((ltfce.MO_Evaluation/ltfce.Total_Presumptives_By_Nurse)*100) where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_clinical_evaluation ltfce set  Percentage_Presumptives_Missing_Clinical_Evaluation =((Presumptives_Missing_Clinical_Evaluation/MO_Evaluation)) * 100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_clinical_evaluation ltfce set Percentage_Tb_Presumptive_Confirmed=(Tb_Presumptive_Confirmed/ MO_Evaluation ) * 100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));
update gfatm_dw.fact_chtb_ltf_clinical_evaluation ltfce set Percentage_Not_Tb_Presumptive =(Not_Tb_Presumptive/MO_Evaluation)*100 where datetime_id>= (select datetime_id from dim_datetime where full_date=(current_date()-interval 1 month));

RESET QUERY CACHE;

end$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE treatment_tb_script()
BEGIN
DROP TABLE IF EXISTS fact_chtb_treatment_tb;
CREATE TABLE IF NOT EXISTS gfatm_dw.fact_chtb_treatment_tb (implementation_id int(11) NOT NULL,datetime_id bigint(21) NOT NULL, 
 location_id int(11) NOT NULL ,  tb_diagnosed decimal(10,2), tb_treatment_initiated decimal(10,2), percentage_tb_treatment_initiated decimal(10,2),
missed_tb_follow_up decimal(10,2), percentage_missed_tb_follow_up decimal(10,2), on_tb_treatment decimal(10,2), percentage_on_tb_treatment decimal(10,2),
cured decimal(10,2), percentage_cured decimal(10,2), treatment_completed decimal(10,2), percentage_treatment_completed decimal(10,2), died decimal(10,2),
percentage_died decimal(10,2), transfer_out decimal(10,2), percentage_transfer_out decimal(10,2), treatment_failure decimal(10,2), percentage_treatment_failure decimal(10,2),
lost_to_followUp decimal(10,2), percentage_lost_to_followup decimal(10,2)) engine=MYISAM default charset=latin1;

insert into gfatm_dw.fact_chtb_treatment_tb (datetime_id,implementation_id,location_id)(
select  datetime_id, implementation_id,  location_id from gfatm_dw.fact_encounter
where  encounter_type IN(51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,81,82,83,84,85,86,87,160) and location_id is not null  group by  datetime_id, location_id  order by location_id ASC);

update gfatm_dw.fact_chtb_treatment_tb  ttb set tb_diagnosed=(select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t 
left join dim_datetime  as d on d.full_date = date(t.date_entered) 
where t.tb_patient='yes' and  t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id= ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id= ttb.implementation_id and d.full_date>='2017-01-01' );


update gfatm_dw.fact_chtb_treatment_tb ttb set tb_treatment_initiated=(select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t left join dim_datetime as d on d.full_date = date(t.date_entered) where t.tb_patient='yes' and t.treatment_initiated='yes' and   t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');

update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_tb_treatment_initiated=(ttb.tb_treatment_initiated/ttb.tb_diagnosed)*100;

update gfatm_dw.fact_chtb_treatment_tb ttb set  missed_tb_follow_up =(
select count(*) from  gfatm_dw.enc_childhood_tb_treatment_initiation t
inner join gfatm_dw.enc_childhood_tb_tb_treatment_followup f 
on t.patient_id= f.patient_id and f.date_entered=(Select max(date_entered)from enc_childhood_tb_tb_treatment_followup where patient_id=f.patient_id)
left join dim_datetime as d on d.full_date = date (t.date_entered)   
where ((date(f.date_entered)<= curdate()- interval 2 month ) or (f.patient_id is null)) and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id)
 and t.tb_patient='yes'  and d.datetime_id=ttb.datetime_id
 and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');	

update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_missed_tb_follow_up=(ttb.missed_tb_follow_up/ttb.tb_treatment_initiated) * 100;

update gfatm_dw.fact_chtb_treatment_tb ttb set on_tb_treatment=
(select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t
 inner join gfatm_dw.enc_childhood_tb_tb_treatment_followup f on t.patient_id=f.patient_id
 and f.date_entered=(Select max(date_entered)from enc_childhood_tb_tb_treatment_followup 
where patient_id=f.patient_id) 
left join gfatm_dw.enc_tb_end_of_followup e 
on t.patient_id=e.patient_id and e.date_entered=(Select max(date_entered) from gfatm_dw.enc_tb_end_of_followup 
where patient_id=e.patient_id) left join dim_datetime as d on d.full_date=date(t.date_entered) 
  where ((date(f.date_entered)>= curdate()- interval 2 month ) and (e.patient_id is null)) and t.tb_patient='yes'
and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id)
 and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');

update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_on_tb_treatment=(on_tb_treatment/tb_treatment_initiated)*100;

update gfatm_dw.fact_chtb_treatment_tb ttb set cured= (select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t  inner join gfatm_dw.enc_end_of_followup e on t.patient_id=e.patient_id  and e.date_entered=(Select max(date_entered) from gfatm_dw.enc_end_of_followup 
where patient_id=e.patient_id)left join dim_datetime as d on d.full_date = date(t.date_entered) where e.treatment_outcome='CURE' and  t.tb_patient='yes' and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');
update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_cured=(cured/tb_treatment_initiated)*100;

update gfatm_dw.fact_chtb_treatment_tb ttb set Treatment_Completed= (select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t  inner join gfatm_dw.enc_end_of_followup e on t.patient_id=e.patient_id and e.date_entered=(Select max(date_entered) from gfatm_dw.enc_end_of_followup 
where patient_id=e.patient_id) left join dim_datetime as d on d.full_date = date(t.date_entered) where e.treatment_outcome='treatment completed' and  t.tb_patient='yes' and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');
update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_treatment_completed=(Treatment_Completed/tb_treatment_initiated) *100;

update gfatm_dw.fact_chtb_treatment_tb ttb set died=(select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t  inner join gfatm_dw.enc_end_of_followup e on t.patient_id=e.patient_id left join dim_datetime as d on d.full_date = date(t.date_entered) where e.treatment_outcome='died' and  t.tb_patient='yes'  and e.date_entered=(Select max(date_entered) from gfatm_dw.enc_end_of_followup 
where patient_id=e.patient_id) and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');
update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_died=(died/tb_treatment_initiated)*100;

update gfatm_dw.fact_chtb_treatment_tb ttb set transfer_out=(select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t inner join gfatm_dw.enc_end_of_followup e  on t.patient_id=e.patient_id and  e.date_entered=(Select max(date_entered) from gfatm_dw.enc_end_of_followup 
where patient_id=e.patient_id) left join dim_datetime as d on d.full_date = date(t.date_entered) where e.treatment_outcome='transferred_out' and  t.tb_patient='yes' and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');

update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_transfer_out=(transfer_out/tb_treatment_initiated)*100;

update gfatm_dw.fact_chtb_treatment_tb ttb set treatment_failure=(select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t  inner join gfatm_dw.enc_end_of_followup e on t.patient_id=e.patient_id and e.date_entered=(Select max(date_entered) from gfatm_dw.enc_end_of_followup 
where patient_id=e.patient_id) left join dim_datetime as d on d.full_date = date(t.date_entered) where e.treatment_outcome='tb_treatment_failure' and  t.tb_patient='yes' and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');

update gfatm_dw.fact_chtb_treatment_tb ttb set percentage_treatment_failure =(treatment_failure/tb_treatment_initiated)*100;

update gfatm_dw.fact_chtb_treatment_tb ttb set lost_to_followUp=(select count(*) from gfatm_dw.enc_childhood_tb_treatment_initiation t inner join gfatm_dw.enc_end_of_followup e on e.patient_id=t.patient_id and e.date_entered=(Select max(date_entered) from gfatm_dw.enc_end_of_followup 
where patient_id=e.patient_id) left join dim_datetime as d on d.full_date = date(t.date_entered) where e.treatment_outcome='DEFAULT' and  t.tb_patient='yes' and t.date_entered=(Select max(date_entered) from gfatm_dw.enc_childhood_tb_treatment_initiation 
where patient_id=t.patient_id) and d.datetime_id=ttb.datetime_id and t.location_id= ttb.location_id and t.implementation_id=ttb.implementation_id and d.full_date>='2017-01-01');
update gfatm_dw.fact_chtb_treatment_tb ttb set  percentage_lost_to_followup=(lost_to_followUp/tb_treatment_initiated)*100;
END$$
DELIMITER ;


-- ----------------
-- CREATE FUNCTIONS
-- ----------------
DELIMITER $$
CREATE FUNCTION get_age_group(
	age INT
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE age_group VARCHAR(20);
    IF age BETWEEN 15 AND 24 THEN
		SET age_group = '15-24';
    ELSEIF age BETWEEN 25 AND 34 THEN
		SET age_group = '25-34';
    ELSEIF age BETWEEN 35 AND 44 THEN
		SET age_group = '35-44';
    ELSEIF age BETWEEN 45 AND 54 THEN
		SET age_group = '45-54';
    ELSEIF age BETWEEN 55 AND 64 THEN
		SET age_group = '55-64';
    ELSEIF age > 64 THEN
        SET age_group = '65 +';
    END IF;
	RETURN (age_group);
END$$
DELIMITER ;

-- ------------
-- CREATE VIEWS
-- ------------
CREATE VIEW cobmine_view AS
SELECT 'x-rayed' AS stage, GET_AGE_GROUP(YEAR(dp.date_created) - YEAR(dp.birthdate)) AS age_group, SUM(IF((dp.gender = 'm'), 1, 0)) AS male, SUM(IF((dp.gender = 'f'), 1, 0)) AS female, COUNT(dp.patient_id) AS total
FROM enc_cxr_screening_test_order AS cxr_order
    INNER JOIN dim_patient AS dp ON dp.patient_id = cxr_order.patient_id
    INNER JOIN enc_cxr_screening_test_result AS cxr_result ON cxr_result.patient_id = cxr_order.patient_id AND cxr_result.order_id = cxr_order.order_id AND cxr_result.encounter_id = 
		(SELECT MAX(enc_cxr_screening_test_result.encounter_id) FROM enc_cxr_screening_test_result WHERE enc_cxr_screening_test_result.order_id = cxr_order.order_id AND enc_cxr_screening_test_result.patient_id = cxr_result.patient_id)
    LEFT JOIN enc_patient_information pi ON pi.patient_id = cxr_order.patient_id AND pi.encounter_id = 
		(SELECT MAX(enc_patient_information.encounter_id) FROM enc_patient_information WHERE enc_patient_information.patient_id = pi.patient_id)
    LEFT JOIN enc_fast_presumptive AS presumptive ON presumptive.patient_id = cxr_order.patient_id AND presumptive.encounter_id = 
		(SELECT MAX(enc_fast_presumptive.encounter_id) FROM enc_fast_presumptive WHERE enc_fast_presumptive.patient_id = presumptive.patient_id)
	WHERE YEAR(dp.date_created) - YEAR(dp.birthdate) >= 15 AND presumptive.screening_type = 'cxr_screening' AND pi.patient_source IN ('screening' , 'referral', 'tb_contact') 
        AND (cxr_result.cxr_done = 'yes' OR ISNULL(cxr_result.cxr_done))
        AND YEAR(cxr_order.date_entered) = 2018 
		AND cxr_order.encounter_id IN 
		(SELECT encounter_view.enc_id FROM encounter_view)
GROUP BY age_group 
UNION 
SELECT 'presumptive' AS stage, GET_AGE_GROUP(YEAR(dp.date_created) - YEAR(dp.birthdate)) AS age_group, SUM(IF((dp.gender = 'm'), 1, 0)) AS male, SUM(IF((dp.gender = 'f'), 1, 0)) AS female, COUNT(dp.patient_id) AS total
FROM enc_cxr_screening_test_order AS cxr_order
    INNER JOIN dim_patient AS dp ON dp.patient_id = cxr_order.patient_id
    INNER JOIN enc_cxr_screening_test_result AS cxr_result ON cxr_result.patient_id = cxr_order.patient_id AND cxr_result.order_id = cxr_order.order_id AND cxr_result.encounter_id = 
		(SELECT MAX(enc_cxr_screening_test_result.encounter_id) FROM enc_cxr_screening_test_result WHERE enc_cxr_screening_test_result.order_id = cxr_order.order_id AND enc_cxr_screening_test_result.patient_id = cxr_result.patient_id)
    LEFT JOIN enc_patient_information pi ON pi.patient_id = cxr_order.patient_id AND pi.encounter_id = 
		(SELECT MAX(enc_patient_information.encounter_id) FROM enc_patient_information WHERE enc_patient_information.patient_id = pi.patient_id)
    LEFT JOIN enc_fast_presumptive AS presumptive ON presumptive.patient_id = cxr_order.patient_id AND presumptive.encounter_id = 
		(SELECT MAX(enc_fast_presumptive.encounter_id) FROM enc_fast_presumptive WHERE enc_fast_presumptive.patient_id = presumptive.patient_id)
	WHERE YEAR(dp.date_created) - YEAR(dp.birthdate) >= 15 AND presumptive.screening_type = 'cxr_screening' AND pi.patient_source IN ('screening' , 'referral', 'tb_contact')
			AND (cxr_result.cxr_done = 'yes' OR ISNULL(cxr_result.cxr_done))
			AND YEAR(cxr_order.date_entered) = 2018 
			AND cxr_order.encounter_id IN (SELECT encounter_view.enc_id FROM encounter_view)
			AND (cxr_result.presumptive_tb_cxr = 'yes')
GROUP BY age_group;


CREATE VIEW cumulative_xrayed AS
    SELECT 
        DATE_FORMAT(cxr_order.date_entered, '%b-%Y') AS month_year,
        COUNT(cxr_result.order_id) AS x_rayed
    FROM
        enc_cxr_screening_test_order AS cxr_order
            LEFT JOIN
        dim_patient PT ON PT.patient_id = cxr_order.patient_id
            LEFT JOIN
        enc_cxr_screening_test_result cxr_result ON cxr_result.patient_id = cxr_order.patient_id
            AND cxr_result.order_id = cxr_order.order_id
    WHERE
        cxr_order.reason_for_xray = 'screening'
            AND (YEAR(PT.date_created) - YEAR(PT.birthdate)) >= 15
            AND cxr_order.encounter_id = (SELECT 
                MIN(enc_cxr_screening_test_order.encounter_id)
            FROM
                enc_cxr_screening_test_order
            WHERE
                enc_cxr_screening_test_order.patient_id = cxr_order.patient_id)
            AND cxr_result.order_id IS NOT NULL
    GROUP BY YEAR(cxr_order.date_entered) , MONTH(cxr_order.date_entered)
    ORDER BY cxr_order.date_entered;


CREATE VIEW encounter_view AS
    SELECT 
        MAX(enc_cxr_screening_test_order.encounter_id) AS enc_id
    FROM
        enc_cxr_screening_test_order
    WHERE
        enc_cxr_screening_test_order.reason_for_xray = 'screening'
            AND enc_cxr_screening_test_order.scrnngxr_type LIKE '%chest_xray%'
    GROUP BY enc_cxr_screening_test_order.patient_id;


CREATE VIEW encounter_view2 AS
    SELECT 
        MIN(enc_cxr_screening_test_order.encounter_id) AS enc_id
    FROM
        enc_cxr_screening_test_order
    WHERE
        enc_cxr_screening_test_order.reason_for_xray = 'screening'
            AND enc_cxr_screening_test_order.scrnngxr_type IN ('chest_xray,xray_other' , 'xray_other,chest_xray', 'chest_xray')
    GROUP BY enc_cxr_screening_test_order.patient_id
    HAVING COUNT(enc_cxr_screening_test_order.patient_id) > 1
        AND TO_DAYS(MAX(enc_cxr_screening_test_order.date_entered)) - TO_DAYS(MIN(enc_cxr_screening_test_order.date_entered)) > 180;


CREATE VIEW quantiferon AS
    SELECT 
        lt.test_order_id AS test_order_id,
        lt.patient_id AS patient_id,
        lt.encounter_id AS encounter_id,
        lt.order_number AS order_number,
        lt.order_date AS order_date,
        lt.lab_reference_number AS lab_reference_number,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 27),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS run_number,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 37),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS run_date,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 28),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS valid_test,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 29),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS nil,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 30),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS tb1,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 31),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS tb2,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 32),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS mitogen,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 33),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS tb1_nil,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 34),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS tb2_nil,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 35),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS mitogen_nil,
        GROUP_CONCAT(IF((ltr.attribute_type_id = 36),
                CONCAT(ltr.value_reference),
                NULL)
            SEPARATOR ',') AS result
    FROM
        (dim_lab_test lt
        LEFT JOIN dim_lab_test_result ltr ON ((ltr.test_order_id = lt.test_order_id)))
    WHERE
        (lt.test_type_id = 42)
    GROUP BY lt.test_order_id;
