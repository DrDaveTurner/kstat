/* cleanup commands, will reset to clean db, comment out if not needed */
drop index if exists job_gpu_metrics_job_id_idx;
drop index if exists job_gpu_metrics_time_stamp_idx;
drop table if exists job_gpu_metrics;
drop index if exists job_metrics_job_id_idx;
drop index if exists job_metrics_time_stamp_idx;
drop table if exists job_metrics;
drop index if exists node_metrics_time_stamp_idx;
drop table if exists node_metrics;
drop table if exists node_gpus;
drop table if exists nodes;
/*
*/

/* create tables and indexes */
create table nodes (
    node_id serial primary key,
    node_name varchar(50) not null,
    total_cores integer,
    total_mem integer,
    owner varchar(50),
    gpu_count integer,
    local_disk integer,
    last_scanned timestamp
);

create table node_gpus (
    node_gpu_id serial primary key,
    node_id integer not null,
    gpu_name varchar(50),
    gpu_num integer,
    gpu_uuid varchar(50),
    gpu_total_mem integer,
    foreign key (node_id) references nodes (node_id)
);

create table node_metrics (
    node_metric_id serial primary key,
    node_id integer not null,
    time_stamp timestamp not null,
    cores_used integer,
    cpu_load real,
    cpu_user real,
    cpu_system real,
    cpu_idle real,
    cpu_io real,
    mem_used real,
    mem_alloc real,
    foreign key (node_id) references nodes (node_id)
);
create index node_metrics_time_stamp_idx on node_metrics (time_stamp);

create table job_metrics (
    job_metric_id serial primary key,
    node_id integer not null,
    job_id integer not null,
    time_stamp timestamp not null,
    job_ncores integer,
    cpu_user real,
    cpu_system real,
    cpu_idle real,
    cpu_io real,
    mem_used real,
    max_mem_used real,
    swap_mem_used real,
    max_swap_mem_used real,
    foreign key (node_id) references nodes (node_id)
);
create index job_metrics_job_id_idx on job_metrics (job_id);
create index job_metrics_time_stamp_idx on job_metrics (time_stamp);

create table job_gpu_metrics (
    job_gpu_metric_id serial not null,
    node_id integer not null,
    node_gpu_id integer not null,
    job_id integer not null,
    time_stamp timestamp not null,
    gpu_utilization real,
    gpu_mem_used integer,
    foreign key (node_id) references nodes (node_id),
    foreign key (node_gpu_id) references node_gpus (node_gpu_id)
);
create index job_gpu_metrics_job_id_idx on job_gpu_metrics(job_id);
create index job_gpu_metrics_time_stamp_idx on job_gpu_metrics(time_stamp);
