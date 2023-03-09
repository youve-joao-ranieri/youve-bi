-- For PostgreSQL
DROP TABLE IF EXISTS p_audit_log;
DROP TABLE IF EXISTS p_saved_query;
DROP TABLE IF EXISTS p_shared_report;
DROP TABLE IF EXISTS p_user_favourite;
DROP TABLE IF EXISTS p_group_report;
DROP TABLE IF EXISTS p_component;
DROP TABLE IF EXISTS p_report;
DROP TABLE IF EXISTS p_datasource;
DROP TABLE IF EXISTS p_user_attribute;
DROP TABLE IF EXISTS p_canned_report;
DROP TABLE IF EXISTS p_group_user;
DROP TABLE IF EXISTS p_user;
DROP TABLE IF EXISTS p_group;

CREATE TABLE
IF NOT EXISTS p_datasource (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    username VARCHAR,
    password VARCHAR,
    connection_url VARCHAR,
    driver_class_name VARCHAR,
    ping VARCHAR
);

CREATE TABLE
IF NOT EXISTS p_report (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    style VARCHAR,
    project VARCHAR
);

CREATE TABLE
IF NOT EXISTS p_component (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    report_id BIGINT NOT NULL,
    datasource_id BIGINT,
    title VARCHAR,
    x BIGINT NOT NULL,
    y BIGINT NOT NULL,
    width BIGINT NOT NULL,
    height BIGINT NOT NULL,
    type VARCHAR NOT NULL,
    sub_type VARCHAR,
    sql_query VARCHAR,
    data VARCHAR,
    drill_through VARCHAR,
    style VARCHAR,
    FOREIGN KEY (report_id) REFERENCES p_report(id)
);

CREATE TABLE 
IF NOT EXISTS p_user (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR NOT NULL UNIQUE,
    name VARCHAR,
    password VARCHAR,
    temp_password VARCHAR,
    session_key VARCHAR,
    session_timeout BIGINT, 
    api_key VARCHAR,
    sys_role VARCHAR NOT NULL
);

CREATE TABLE 
IF NOT EXISTS p_group (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE
); 

CREATE TABLE 
IF NOT EXISTS p_group_user (
    user_id BIGINT NOT NULL,
    group_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, group_id),
    FOREIGN KEY (user_id) REFERENCES p_user(id),
    FOREIGN KEY (group_id) REFERENCES p_group(id)
); 

CREATE TABLE 
IF NOT EXISTS p_group_report (
    report_id BIGINT NOT NULL,
    group_id BIGINT NOT NULL,
    PRIMARY KEY (report_id, group_id),
    FOREIGN KEY (report_id) REFERENCES p_report(id),
    FOREIGN KEY (group_id) REFERENCES p_group(id)
);

CREATE TABLE
IF NOT EXISTS p_canned_report (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at BIGINT NOT NULL,
    name VARCHAR NOT NULL,
    data VARCHAR,
    FOREIGN KEY (user_id) REFERENCES p_user(id)
);

CREATE TABLE
IF NOT EXISTS p_user_attribute (
    user_id INTEGER NOT NULL,
    attr_key VARCHAR NOT NULL,
    attr_value VARCHAR,
    FOREIGN KEY (user_id) REFERENCES p_user(id)
);

-- v0.10.0 new tables
CREATE TABLE
IF NOT EXISTS p_user_favourite (
    user_id INTEGER NOT NULL,
    report_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, report_id),
    FOREIGN KEY (user_id) REFERENCES p_user(id),
    FOREIGN KEY (report_id) REFERENCES p_report(id)
);

CREATE TABLE
IF NOT EXISTS p_shared_report (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    share_key VARCHAR NOT NULL,
    report_id INTEGER NOT NULL,
    report_type VARCHAR NOT NULL,
    user_id INTEGER NOT NULL,
    created_at BIGINT NOT NULL,
    expired_by BIGINT NOT NULL,
    FOREIGN KEY (report_id) REFERENCES p_report(id),
    FOREIGN KEY (user_id) REFERENCES p_user(id)
);

CREATE TABLE
IF NOT EXISTS p_saved_query (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    datasource_id INTEGER,
    name VARCHAR NOT NULL UNIQUE,
    sql_query VARCHAR,
    endpoint_name VARCHAR UNIQUE,
    endpoint_accesscode VARCHAR
);

CREATE TABLE
IF NOT EXISTS p_audit_log (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at INTEGER NOT NULL,
    type VARCHAR NOT NULL,
    data VARCHAR
);

CREATE INDEX idx_audit_log_created_at ON p_audit_log (created_at);


INSERT INTO p_user(username, temp_password, sys_role)
VALUES('admin', 'f6fdffe48c908deb0f4c3bd36c032e72', 'admin');