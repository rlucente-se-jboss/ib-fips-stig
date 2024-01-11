#!/usr/bin/env bash

TAILOR_FILE=ssg-rhel9-ds-tailoring-high-only.xml
NEW_PROFILE=xccdf_org.ssgproject.content_profile_stig_high_only

autotailor \
    --output ${TAILOR_FILE} \
    --new-profile-id ${NEW_PROFILE} \
    -u account_disable_post_pw_expiration \
    -u account_password_pam_faillock_password_auth \
    -u account_password_pam_faillock_system_auth \
    -u account_password_selinux_faillock_dir \
    -u accounts_authorized_local_users \
    -u accounts_have_homedir_login_defs \
    -u accounts_logon_fail_delay \
    -u accounts_max_concurrent_login_sessions \
    -u accounts_maximum_age_login_defs \
    -u accounts_minimum_age_login_defs \
    -u accounts_no_uid_except_zero \
    -u accounts_password_all_shadowed \
    -u accounts_password_all_shadowed_sha512 \
    -u accounts_password_last_change_is_in_past \
    -u accounts_password_minlen_login_defs \
    -u accounts_password_pam_dcredit \
    -u accounts_password_pam_dictcheck \
    -u accounts_password_pam_difok \
    -u accounts_password_pam_enforce_root \
    -u accounts_password_pam_lcredit \
    -u accounts_password_pam_maxclassrepeat \
    -u accounts_password_pam_maxrepeat \
    -u accounts_password_pam_minclass \
    -u accounts_password_pam_minlen \
    -u accounts_password_pam_ocredit \
    -u accounts_password_pam_pwhistory_remember_password_auth \
    -u accounts_password_pam_pwhistory_remember_system_auth \
    -u accounts_password_pam_pwquality_password_auth \
    -u accounts_password_pam_pwquality_system_auth \
    -u accounts_password_pam_retry \
    -u accounts_password_pam_ucredit \
    -u accounts_password_pam_unix_remember \
    -u accounts_password_pam_unix_rounds_password_auth \
    -u accounts_password_pam_unix_rounds_system_auth \
    -u accounts_password_set_max_life_existing \
    -u accounts_password_set_min_life_existing \
    -u accounts_password_set_warn_age_existing \
    -u accounts_passwords_pam_faillock_audit \
    -u accounts_passwords_pam_faillock_deny_root \
    -u accounts_passwords_pam_faillock_deny \
    -u accounts_passwords_pam_faillock_dir \
    -u accounts_passwords_pam_faillock_interval \
    -u accounts_passwords_pam_faillock_unlock_time \
    -u accounts_password_warn_age_login_defs \
    -u accounts_polyinstantiated_tmp \
    -u accounts_polyinstantiated_var_tmp \
    -u accounts_root_gid_zero \
    -u accounts_root_path_dirs_no_write \
    -u accounts_set_post_pw_existing \
    -u accounts_tmout \
    -u accounts_umask_etc_bashrc \
    -u accounts_umask_etc_csh_cshrc \
    -u accounts_umask_etc_login_defs \
    -u accounts_umask_etc_profile \
    -u accounts_umask_interactive_users \
    -u accounts_user_dot_no_world_writable_programs \
    -u accounts_user_home_paths_only \
    -u accounts_user_interactive_home_directory_defined \
    -u accounts_user_interactive_home_directory_exists \
    -u account_temp_expire_date \
    -u account_unique_id \
    -u account_unique_name \
    -u agent_mfetpd_running \
    -u aide_build_database \
    -u aide_check_audit_tools \
    -u aide_periodic_cron_checking \
    -u aide_scan_notification \
    -u aide_use_fips_hashes \
    -u aide_verify_acls \
    -u aide_verify_ext_attributes \
    -u audit_access_failed_aarch64 \
    -u audit_access_failed_ppc64le \
    -u audit_access_failed \
    -u audit_access_success_aarch64 \
    -u audit_access_success_ppc64le \
    -u audit_access_success \
    -u audit_basic_configuration \
    -u audit_create_failed_aarch64 \
    -u audit_create_failed_ppc64le \
    -u audit_create_failed \
    -u audit_create_success_aarch64 \
    -u audit_create_success_ppc64le \
    -u audit_create_success \
    -u auditd_audispd_configure_sufficiently_large_partition \
    -u auditd_audispd_syslog_plugin_activated \
    -u auditd_data_disk_error_action_stig \
    -u auditd_data_disk_full_action_stig \
    -u auditd_data_retention_action_mail_acct \
    -u auditd_data_retention_admin_space_left_action \
    -u auditd_data_retention_admin_space_left_percentage \
    -u auditd_data_retention_flush \
    -u auditd_data_retention_max_log_file_action \
    -u auditd_data_retention_max_log_file_action_stig \
    -u auditd_data_retention_max_log_file \
    -u auditd_data_retention_num_logs \
    -u auditd_data_retention_space_left_action \
    -u auditd_data_retention_space_left_percentage \
    -u audit_delete_failed_aarch64 \
    -u audit_delete_failed_ppc64le \
    -u audit_delete_failed \
    -u audit_delete_success_aarch64 \
    -u audit_delete_success_ppc64le \
    -u audit_delete_success \
    -u auditd_freq \
    -u auditd_local_events \
    -u auditd_log_format \
    -u auditd_name_format \
    -u auditd_overflow_action \
    -u auditd_write_logs \
    -u audit_immutable_login_uids \
    -u audit_modify_failed_aarch64 \
    -u audit_modify_failed_ppc64le \
    -u audit_modify_failed \
    -u audit_modify_success_aarch64 \
    -u audit_modify_success_ppc64le \
    -u audit_modify_success \
    -u audit_module_load_ppc64le \
    -u audit_module_load \
    -u audit_ospp_general_aarch64 \
    -u audit_ospp_general_ppc64le \
    -u audit_ospp_general \
    -u audit_owner_change_failed_aarch64 \
    -u audit_owner_change_failed_ppc64le \
    -u audit_owner_change_failed \
    -u audit_owner_change_success_aarch64 \
    -u audit_owner_change_success_ppc64le \
    -u audit_owner_change_success \
    -u audit_perm_change_failed_aarch64 \
    -u audit_perm_change_failed_ppc64le \
    -u audit_perm_change_failed \
    -u audit_perm_change_success_aarch64 \
    -u audit_perm_change_success_ppc64le \
    -u audit_perm_change_success \
    -u audit_privileged_commands_init \
    -u audit_privileged_commands_poweroff \
    -u audit_privileged_commands_reboot \
    -u audit_privileged_commands_shutdown \
    -u audit_rules_dac_modification_chmod \
    -u audit_rules_dac_modification_chown \
    -u audit_rules_dac_modification_fchmodat \
    -u audit_rules_dac_modification_fchmod \
    -u audit_rules_dac_modification_fchownat \
    -u audit_rules_dac_modification_fchown \
    -u audit_rules_dac_modification_fremovexattr \
    -u audit_rules_dac_modification_fsetxattr \
    -u audit_rules_dac_modification_lchown \
    -u audit_rules_dac_modification_lremovexattr \
    -u audit_rules_dac_modification_lsetxattr \
    -u audit_rules_dac_modification_removexattr \
    -u audit_rules_dac_modification_setxattr \
    -u audit_rules_dac_modification_umount2 \
    -u audit_rules_dac_modification_umount \
    -u audit_rules_execution_chacl \
    -u audit_rules_execution_chcon \
    -u audit_rules_execution_restorecon \
    -u audit_rules_execution_semanage \
    -u audit_rules_execution_setfacl \
    -u audit_rules_execution_setfiles \
    -u audit_rules_execution_setsebool \
    -u audit_rules_execution_seunshare \
    -u audit_rules_file_deletion_events_renameat \
    -u audit_rules_file_deletion_events_rename \
    -u audit_rules_file_deletion_events_rmdir \
    -u audit_rules_file_deletion_events_unlinkat \
    -u audit_rules_file_deletion_events_unlink \
    -u audit_rules_immutable \
    -u audit_rules_kernel_module_loading_create \
    -u audit_rules_kernel_module_loading_delete \
    -u audit_rules_kernel_module_loading_finit \
    -u audit_rules_kernel_module_loading_init \
    -u audit_rules_kernel_module_loading_query \
    -u audit_rules_kernel_module_loading \
    -u audit_rules_login_events_faillock \
    -u audit_rules_login_events_lastlog \
    -u audit_rules_login_events \
    -u audit_rules_login_events_tallylog \
    -u audit_rules_mac_modification \
    -u audit_rules_mac_modification_usr_share \
    -u audit_rules_media_export \
    -u audit_rules_networkconfig_modification \
    -u audit_rules_privileged_commands_chage \
    -u audit_rules_privileged_commands_chsh \
    -u audit_rules_privileged_commands_crontab \
    -u audit_rules_privileged_commands_gpasswd \
    -u audit_rules_privileged_commands_kmod \
    -u audit_rules_privileged_commands_mount \
    -u audit_rules_privileged_commands_newgrp \
    -u audit_rules_privileged_commands_pam_timestamp_check \
    -u audit_rules_privileged_commands_passwd \
    -u audit_rules_privileged_commands_postdrop \
    -u audit_rules_privileged_commands_postqueue \
    -u audit_rules_privileged_commands \
    -u audit_rules_privileged_commands_ssh_agent \
    -u audit_rules_privileged_commands_ssh_keysign \
    -u audit_rules_privileged_commands_sudoedit \
    -u audit_rules_privileged_commands_sudo \
    -u audit_rules_privileged_commands_su \
    -u audit_rules_privileged_commands_umount \
    -u audit_rules_privileged_commands_unix_chkpwd \
    -u audit_rules_privileged_commands_unix_update \
    -u audit_rules_privileged_commands_userhelper \
    -u audit_rules_privileged_commands_usermod \
    -u audit_rules_session_events \
    -u audit_rules_sudoers_d \
    -u audit_rules_sudoers \
    -u audit_rules_suid_auid_privilege_function \
    -u audit_rules_suid_privilege_function \
    -u audit_rules_sysadmin_actions \
    -u audit_rules_system_shutdown \
    -u audit_rules_time_adjtimex \
    -u audit_rules_time_clock_settime \
    -u audit_rules_time_settimeofday \
    -u audit_rules_time_stime \
    -u audit_rules_time_watch_localtime \
    -u audit_rules_unsuccessful_file_modification_creat \
    -u audit_rules_unsuccessful_file_modification_ftruncate \
    -u audit_rules_unsuccessful_file_modification_openat \
    -u audit_rules_unsuccessful_file_modification_open_by_handle_at \
    -u audit_rules_unsuccessful_file_modification_open \
    -u audit_rules_unsuccessful_file_modification \
    -u audit_rules_unsuccessful_file_modification_truncate \
    -u audit_rules_usergroup_modification_group \
    -u audit_rules_usergroup_modification_gshadow \
    -u audit_rules_usergroup_modification_opasswd \
    -u audit_rules_usergroup_modification_passwd \
    -u audit_rules_usergroup_modification \
    -u audit_rules_usergroup_modification_shadow \
    -u audit_sudo_log_events \
    -u banner_etc_issue_net \
    -u banner_etc_issue \
    -u banner_etc_motd \
    -u chronyd_client_only \
    -u chronyd_no_chronyc_network \
    -u chronyd_or_ntpd_set_maxpoll \
    -u chronyd_run_as_chrony_user \
    -u chronyd_server_directive \
    -u chronyd_specify_remote_server \
    -u clean_components_post_updating \
    -u configure_bashrc_exec_tmux \
    -u configure_bind_crypto_policy \
    -u configure_crypto_policy \
    -u configured_firewalld_default_deny \
    -u configure_firewalld_ports \
    -u configure_kerberos_crypto_policy \
    -u configure_libreswan_crypto_policy \
    -u configure_opensc_card_drivers \
    -u configure_openssl_crypto_policy \
    -u configure_openssl_tls_crypto_policy \
    -u configure_ssh_crypto_policy \
    -u configure_tmux_lock_after_time \
    -u configure_tmux_lock_command \
    -u configure_usbguard_auditbackend \
    -u coredump_disable_backtraces \
    -u coredump_disable_storage \
    -u dconf_db_up_to_date \
    -u dconf_gnome_banner_enabled \
    -u dconf_gnome_disable_automount_open \
    -u dconf_gnome_disable_automount \
    -u dconf_gnome_disable_autorun \
    -u dconf_gnome_disable_ctrlaltdel_reboot \
    -u dconf_gnome_disable_restart_shutdown \
    -u dconf_gnome_disable_user_list \
    -u dconf_gnome_lock_screen_on_smartcard_removal \
    -u dconf_gnome_login_banner_text \
    -u dconf_gnome_remote_access_credential_prompt \
    -u dconf_gnome_remote_access_encryption \
    -u dconf_gnome_screensaver_idle_activation_enabled \
    -u dconf_gnome_screensaver_idle_delay \
    -u dconf_gnome_screensaver_lock_delay \
    -u dconf_gnome_screensaver_lock_enabled \
    -u dconf_gnome_screensaver_mode_blank \
    -u dconf_gnome_screensaver_user_locks \
    -u dconf_gnome_session_idle_user_locks \
    -u directory_group_ownership_var_log_audit \
    -u directory_ownership_var_log_audit \
    -u directory_permissions_var_log_audit \
    -u dir_group_ownership_library_dirs \
    -u dir_ownership_library_dirs \
    -u dir_permissions_library_dirs \
    -u dir_perms_world_writable_root_owned \
    -u dir_perms_world_writable_sticky_bits \
    -u disable_ctrlaltdel_reboot \
    -u disable_host_auth \
    -u disable_users_coredumps \
    -u disallow_bypass_password_sudo \
    -u display_login_attempts \
    -u dnf-automatic_apply_updates \
    -u dnf-automatic_security_updates_only \
    -u enable_authselect \
    -u enable_dracut_fips_module \
    -u enable_fips_mode \
    -u encrypt_partitions \
    -u ensure_gpgcheck_globally_activated \
    -u ensure_gpgcheck_local_packages \
    -u ensure_gpgcheck_never_disabled \
    -u ensure_logrotate_activated \
    -u ensure_pam_wheel_group_empty \
    -u ensure_redhat_gpgkey_installed \
    -u ensure_root_password_configured \
    -u file_at_deny_not_exist \
    -u file_audit_tools_group_ownership \
    -u file_audit_tools_ownership \
    -u file_audit_tools_permissions \
    -u file_cron_deny_not_exist \
    -u file_groupowner_at_allow \
    -u file_groupowner_backup_etc_group \
    -u file_groupowner_backup_etc_gshadow \
    -u file_groupowner_backup_etc_passwd \
    -u file_groupowner_backup_etc_shadow \
    -u file_groupowner_cron_allow \
    -u file_groupowner_cron_daily \
    -u file_groupowner_cron_deny \
    -u file_groupowner_cron_d \
    -u file_groupowner_cron_hourly \
    -u file_groupowner_cron_monthly \
    -u file_groupowner_crontab \
    -u file_groupowner_cron_weekly \
    -u file_groupowner_etc_group \
    -u file_groupowner_etc_gshadow \
    -u file_groupowner_etc_issue_net \
    -u file_groupowner_etc_issue \
    -u file_groupowner_etc_motd \
    -u file_groupowner_etc_passwd \
    -u file_groupowner_etc_shadow \
    -u file_groupowner_grub2_cfg \
    -u file_groupownership_audit_binaries \
    -u file_groupownership_audit_configuration \
    -u file_groupownership_home_directories \
    -u file_groupownership_sshd_private_key \
    -u file_groupownership_sshd_pub_key \
    -u file_groupownership_system_commands_dirs \
    -u file_group_ownership_var_log_audit \
    -u file_groupowner_sshd_config \
    -u file_groupowner_user_cfg \
    -u file_groupowner_var_log_messages \
    -u file_groupowner_var_log \
    -u file_owner_backup_etc_group \
    -u file_owner_backup_etc_gshadow \
    -u file_owner_backup_etc_passwd \
    -u file_owner_backup_etc_shadow \
    -u file_owner_cron_allow \
    -u file_owner_cron_daily \
    -u file_owner_cron_deny \
    -u file_owner_cron_d \
    -u file_owner_cron_hourly \
    -u file_owner_cron_monthly \
    -u file_owner_crontab \
    -u file_owner_cron_weekly \
    -u file_owner_etc_group \
    -u file_owner_etc_gshadow \
    -u file_owner_etc_issue_net \
    -u file_owner_etc_issue \
    -u file_owner_etc_motd \
    -u file_owner_etc_passwd \
    -u file_owner_etc_shadow \
    -u file_owner_grub2_cfg \
    -u file_ownership_audit_binaries \
    -u file_ownership_audit_configuration \
    -u file_ownership_binary_dirs \
    -u file_ownership_library_dirs \
    -u file_ownership_sshd_private_key \
    -u file_ownership_sshd_pub_key \
    -u file_ownership_var_log_audit \
    -u file_ownership_var_log_audit_stig \
    -u file_owner_sshd_config \
    -u file_owner_user_cfg \
    -u file_owner_var_log_messages \
    -u file_owner_var_log \
    -u file_permissions_at_allow \
    -u file_permissions_audit_binaries \
    -u file_permissions_audit_configuration \
    -u file_permissions_backup_etc_group \
    -u file_permissions_backup_etc_gshadow \
    -u file_permissions_backup_etc_passwd \
    -u file_permissions_backup_etc_shadow \
    -u file_permissions_binary_dirs \
    -u file_permissions_cron_allow \
    -u file_permissions_cron_daily \
    -u file_permissions_cron_d \
    -u file_permissions_cron_hourly \
    -u file_permissions_cron_monthly \
    -u file_permissions_crontab \
    -u file_permissions_cron_weekly \
    -u file_permissions_etc_audit_auditd \
    -u file_permissions_etc_audit_rulesd \
    -u file_permissions_etc_group \
    -u file_permissions_etc_gshadow \
    -u file_permissions_etc_issue_net \
    -u file_permissions_etc_issue \
    -u file_permissions_etc_motd \
    -u file_permissions_etc_passwd \
    -u file_permissions_etc_shadow \
    -u file_permissions_grub2_cfg \
    -u file_permissions_home_directories \
    -u file_permissions_library_dirs \
    -u file_permissions_sshd_config \
    -u file_permissions_sshd_private_key \
    -u file_permissions_sshd_pub_key \
    -u file_permissions_unauthorized_sgid \
    -u file_permissions_unauthorized_suid \
    -u file_permissions_unauthorized_world_writable \
    -u file_permissions_ungroupowned \
    -u file_permissions_user_cfg \
    -u file_permissions_var_log_audit \
    -u file_permissions_var_log_messages \
    -u file_permissions_var_log \
    -u file_permission_user_init_files \
    -u firewalld-backend \
    -u firewalld_loopback_traffic_restricted \
    -u firewalld_loopback_traffic_trusted \
    -u firewalld_sshd_port_enabled \
    -u force_opensc_card_drivers \
    -u gid_passwd_group_same \
    -u gnome_gdm_disable_automatic_login \
    -u gnome_gdm_disable_xdmcp \
    -u group_unique_id \
    -u grub2_admin_username \
    -u grub2_audit_argument \
    -u grub2_audit_backlog_limit_argument \
    -u grub2_disable_interactive_boot \
    -u grub2_disable_recovery \
    -u grub2_enable_iommu_force \
    -u grub2_enable_selinux \
    -u grub2_init_on_alloc_argument \
    -u grub2_l1tf_argument \
    -u grub2_mce_argument \
    -u grub2_mds_argument \
    -u grub2_nosmap_argument_absent \
    -u grub2_nosmep_argument_absent \
    -u grub2_page_alloc_shuffle_argument \
    -u grub2_page_poison_argument \
    -u grub2_password \
    -u grub2_pti_argument \
    -u grub2_rng_core_default_quality_argument \
    -u grub2_slab_nomerge_argument \
    -u grub2_slub_debug_argument \
    -u grub2_spec_store_bypass_disable_argument \
    -u grub2_spectre_v2_argument \
    -u grub2_systemd_debug-shell_argument_absent \
    -u grub2_uefi_password \
    -u grub2_vsyscall_argument \
    -u harden_sshd_ciphers_opensshserver_conf_crypto_policy \
    -u has_nonlocal_mta \
    -u installed_OS_is_vendor_supported \
    -u install_hids \
    -u install_smartcard_packages \
    -u journald_compress \
    -u journald_forward_to_syslog \
    -u journald_storage \
    -u kerberos_disable_no_keytab \
    -u kernel_config_acpi_custom_method \
    -u kernel_config_arm64_sw_ttbr0_pan \
    -u kernel_config_binfmt_misc \
    -u kernel_config_bug_on_data_corruption \
    -u kernel_config_bug \
    -u kernel_config_compat_brk \
    -u kernel_config_compat_vdso \
    -u kernel_config_debug_credentials \
    -u kernel_config_debug_fs \
    -u kernel_config_debug_list \
    -u kernel_config_debug_notifiers \
    -u kernel_config_debug_sg \
    -u kernel_config_debug_wx \
    -u kernel_config_default_mmap_min_addr \
    -u kernel_config_devkmem \
    -u kernel_config_fortify_source \
    -u kernel_config_gcc_plugin_latent_entropy \
    -u kernel_config_gcc_plugin_randstruct \
    -u kernel_config_gcc_plugin_stackleak \
    -u kernel_config_gcc_plugin_structleak_byref_all \
    -u kernel_config_gcc_plugin_structleak \
    -u kernel_config_hardened_usercopy_fallback \
    -u kernel_config_hardened_usercopy \
    -u kernel_config_hibernation \
    -u kernel_config_ia32_emulation \
    -u kernel_config_kexec \
    -u kernel_config_legacy_ptys \
    -u kernel_config_legacy_vsyscall_emulate \
    -u kernel_config_legacy_vsyscall_none \
    -u kernel_config_legacy_vsyscall_xonly \
    -u kernel_config_modify_ldt_syscall \
    -u kernel_config_module_sig_all \
    -u kernel_config_module_sig_force \
    -u kernel_config_module_sig_hash \
    -u kernel_config_module_sig_key \
    -u kernel_config_module_sig \
    -u kernel_config_module_sig_sha512 \
    -u kernel_config_page_poisoning_no_sanity \
    -u kernel_config_page_poisoning \
    -u kernel_config_page_poisoning_zero \
    -u kernel_config_page_table_isolation \
    -u kernel_config_panic_on_oops \
    -u kernel_config_panic_timeout \
    -u kernel_config_proc_kcore \
    -u kernel_config_randomize_base \
    -u kernel_config_randomize_memory \
    -u kernel_config_refcount_full \
    -u kernel_config_retpoline \
    -u kernel_config_sched_stack_end_check \
    -u kernel_config_seccomp_filter \
    -u kernel_config_seccomp \
    -u kernel_config_security_dmesg_restrict \
    -u kernel_config_security \
    -u kernel_config_security_writable_hooks \
    -u kernel_config_security_yama \
    -u kernel_config_slab_freelist_hardened \
    -u kernel_config_slab_freelist_random \
    -u kernel_config_slab_merge_default \
    -u kernel_config_slub_debug \
    -u kernel_config_stackprotector \
    -u kernel_config_stackprotector_strong \
    -u kernel_config_strict_kernel_rwx \
    -u kernel_config_strict_module_rwx \
    -u kernel_config_syn_cookies \
    -u kernel_config_unmap_kernel_at_el0 \
    -u kernel_config_vmap_stack \
    -u kernel_config_x86_vsyscall_emulation \
    -u kernel_module_atm_disabled \
    -u kernel_module_bluetooth_disabled \
    -u kernel_module_can_disabled \
    -u kernel_module_cramfs_disabled \
    -u kernel_module_firewire-core_disabled \
    -u kernel_module_sctp_disabled \
    -u kernel_module_squashfs_disabled \
    -u kernel_module_tipc_disabled \
    -u kernel_module_udf_disabled \
    -u kernel_module_usb-storage_disabled \
    -u libreswan_approved_tunnels \
    -u logind_session_timeout \
    -u mount_option_boot_efi_nosuid \
    -u mount_option_boot_nodev \
    -u mount_option_boot_noexec \
    -u mount_option_boot_nosuid \
    -u mount_option_dev_shm_nodev \
    -u mount_option_dev_shm_noexec \
    -u mount_option_dev_shm_nosuid \
    -u mount_option_home_nodev \
    -u mount_option_home_noexec \
    -u mount_option_home_nosuid \
    -u mount_option_krb_sec_remote_filesystems \
    -u mount_option_nodev_nonroot_local_partitions \
    -u mount_option_nodev_remote_filesystems \
    -u mount_option_nodev_removable_partitions \
    -u mount_option_noexec_remote_filesystems \
    -u mount_option_noexec_removable_partitions \
    -u mount_option_nosuid_remote_filesystems \
    -u mount_option_nosuid_removable_partitions \
    -u mount_option_opt_nosuid \
    -u mount_option_srv_nosuid \
    -u mount_option_tmp_nodev \
    -u mount_option_tmp_noexec \
    -u mount_option_tmp_nosuid \
    -u mount_option_var_log_audit_nodev \
    -u mount_option_var_log_audit_noexec \
    -u mount_option_var_log_audit_nosuid \
    -u mount_option_var_log_nodev \
    -u mount_option_var_log_noexec \
    -u mount_option_var_log_nosuid \
    -u mount_option_var_nodev \
    -u mount_option_var_noexec \
    -u mount_option_var_nosuid \
    -u mount_option_var_tmp_nodev \
    -u mount_option_var_tmp_noexec \
    -u mount_option_var_tmp_nosuid \
    -u network_configure_name_resolution \
    -u networkmanager_dns_mode \
    -u network_nmcli_permissions \
    -u network_sniffer_disabled \
    -u no_direct_root_logins \
    -u no_empty_passwords_etc_shadow \
    -u no_files_unowned_by_user \
    -u no_forward_files \
    -u no_host_based_files \
    -u no_netrc_files \
    -u no_password_auth_for_systemaccounts \
    -u no_rsh_trust_files \
    -u no_shelllogin_for_systemaccounts \
    -u no_tmux_in_shells \
    -u no_user_host_based_files \
    -u package_aide_installed \
    -u package_audispd-plugins_installed \
    -u package_audit_installed \
    -u package_avahi_removed \
    -u package_bind_removed \
    -u package_chrony_installed \
    -u package_crypto-policies_installed \
    -u package_cups_removed \
    -u package_cyrus-imapd_removed \
    -u package_dhcp_removed \
    -u package_dnf-automatic_installed \
    -u package_dnsmasq_removed \
    -u package_dovecot_removed \
    -u package_fapolicyd_installed \
    -u package_firewalld_installed \
    -u package_ftp_removed \
    -u package_gdm_removed \
    -u package_gnutls-utils_installed \
    -u package_gssproxy_removed \
    -u package_httpd_removed \
    -u package_iprutils_removed \
    -u package_libreswan_installed \
    -u package_libselinux_installed \
    -u package_mcafeetp_installed \
    -u package_mcstrans_removed \
    -u package_net-snmp_removed \
    -u package_nfs-utils_removed \
    -u package_nftables_installed \
    -u package_nginx_removed \
    -u package_nss-tools_installed \
    -u package_openldap-clients_removed \
    -u package_openscap-scanner_installed \
    -u package_opensc_installed \
    -u package_openssh-clients_installed \
    -u package_openssh-server_installed \
    -u package_pcsc-lite_installed \
    -u package_policycoreutils_installed \
    -u package_policycoreutils-python-utils_installed \
    -u package_quagga_removed \
    -u package_rear_installed \
    -u package_rng-tools_installed \
    -u package_rsh_removed \
    -u package_rsh-server_removed \
    -u package_rsync_removed \
    -u package_rsyslog-gnutls_installed \
    -u package_rsyslog_installed \
    -u package_samba_removed \
    -u package_scap-security-guide_installed \
    -u package_sendmail_removed \
    -u package_setroubleshoot-plugins_removed \
    -u package_setroubleshoot_removed \
    -u package_setroubleshoot-server_removed \
    -u package_s-nail_installed \
    -u package_squid_removed \
    -u package_subscription-manager_installed \
    -u package_sudo_installed \
    -u package_talk_removed \
    -u package_talk-server_removed \
    -u package_telnet_removed \
    -u package_telnet-server_removed \
    -u package_tftp_removed \
    -u package_tftp-server_removed \
    -u package_tmux_installed \
    -u package_tuned_removed \
    -u package_usbguard_installed \
    -u package_vsftpd_removed \
    -u package_xinetd_removed \
    -u package_xorg-x11-server-common_removed \
    -u package_ypbind_removed \
    -u package_ypserv_removed \
    -u partition_for_dev_shm \
    -u partition_for_home \
    -u partition_for_srv \
    -u partition_for_tmp \
    -u partition_for_var_log_audit \
    -u partition_for_var_log \
    -u partition_for_var \
    -u partition_for_var_tmp \
    -u postfix_client_configure_mail_alias_postmaster \
    -u postfix_client_configure_mail_alias \
    -u postfix_network_listening_disabled \
    -u postfix_prevent_unrestricted_relay \
    -u prefer_64bit_os \
    -u require_emergency_target_auth \
    -u require_singleuser_auth \
    -u restrict_serial_port_logins \
    -u root_path_no_dot \
    -u root_permissions_syslibrary_files \
    -u rpm_verify_hashes \
    -u rpm_verify_ownership \
    -u rpm_verify_permissions \
    -u rsyslog_cron_logging \
    -u rsyslog_encrypt_offload_actionsendstreamdriverauthmode \
    -u rsyslog_encrypt_offload_actionsendstreamdrivermode \
    -u rsyslog_encrypt_offload_defaultnetstreamdriver \
    -u rsyslog_filecreatemode \
    -u rsyslog_files_groupownership \
    -u rsyslog_files_ownership \
    -u rsyslog_files_permissions \
    -u rsyslog_nolisten \
    -u rsyslog_remote_access_monitoring \
    -u rsyslog_remote_loghost \
    -u rsyslog_remote_tls_cacert \
    -u rsyslog_remote_tls \
    -u sebool_auditadm_exec_content \
    -u sebool_deny_execmem \
    -u sebool_polyinstantiation_enabled \
    -u sebool_selinuxuser_execheap \
    -u sebool_selinuxuser_execmod \
    -u sebool_selinuxuser_execstack \
    -u sebool_ssh_sysadm_login \
    -u securetty_root_login_console_only \
    -u security_patches_up_to_date \
    -u selinux_all_devicefiles_labeled \
    -u selinux_confinement_of_daemons \
    -u selinux_not_disabled \
    -u selinux_policytype \
    -u selinux_state \
    -u service_auditd_enabled \
    -u service_autofs_disabled \
    -u service_avahi-daemon_disabled \
    -u service_chronyd_enabled \
    -u service_crond_enabled \
    -u service_debug-shell_disabled \
    -u service_fapolicyd_enabled \
    -u service_firewalld_enabled \
    -u service_kdump_disabled \
    -u service_nfs_disabled \
    -u service_nftables_disabled \
    -u service_pcscd_enabled \
    -u service_rlogin_disabled \
    -u service_rpcbind_disabled \
    -u service_rsyslog_enabled \
    -u service_snmpd_disabled \
    -u service_squid_disabled \
    -u service_sshd_enabled \
    -u service_systemd-coredump_disabled \
    -u service_systemd-journald_enabled \
    -u service_telnet_disabled \
    -u service_usbguard_enabled \
    -u service_xinetd_disabled \
    -u set_firewalld_default_zone \
    -u set_nftables_table \
    -u set_password_hashing_algorithm_libuserconf \
    -u set_password_hashing_algorithm_logindefs \
    -u set_password_hashing_algorithm_passwordauth \
    -u set_password_hashing_algorithm_systemauth \
    -u set_password_hashing_min_rounds_logindefs \
    -u snmpd_use_newer_protocol \
    -u socket_systemd-journal-remote_disabled \
    -u ssh_client_rekey_limit \
    -u sshd_allow_only_protocol2 \
    -u sshd_disable_compression \
    -u sshd_disable_gssapi_auth \
    -u sshd_disable_kerb_auth \
    -u sshd_disable_rhosts \
    -u sshd_disable_root_login \
    -u sshd_disable_tcp_forwarding \
    -u sshd_disable_user_known_hosts \
    -u sshd_disable_x11_forwarding \
    -u sshd_do_not_permit_user_env \
    -u sshd_enable_pam \
    -u sshd_enable_pubkey_auth \
    -u sshd_enable_strictmodes \
    -u sshd_enable_warning_banner_net \
    -u sshd_enable_warning_banner \
    -u sshd_limit_user_access \
    -u sshd_print_last_log \
    -u sshd_rekey_limit \
    -u sshd_set_idle_timeout \
    -u sshd_set_keepalive \
    -u sshd_set_login_grace_time \
    -u sshd_set_loglevel_info \
    -u sshd_set_loglevel_verbose \
    -u sshd_set_max_auth_tries \
    -u sshd_set_max_sessions \
    -u sshd_set_maxstartups \
    -u sshd_use_directory_configuration \
    -u sshd_use_priv_separation \
    -u sshd_x11_use_localhost \
    -u ssh_keys_passphrase_protected \
    -u sssd_certificate_verification \
    -u sssd_enable_certmap \
    -u sssd_enable_smartcards \
    -u sssd_has_trust_anchor \
    -u sssd_offline_cred_expiration \
    -u sudo_add_noexec \
    -u sudo_add_requiretty \
    -u sudo_add_use_pty \
    -u sudo_custom_logfile \
    -u sudoers_explicit_command_args \
    -u sudoers_no_command_negation \
    -u sudoers_validate_passwd \
    -u sudo_remove_no_authenticate \
    -u sudo_remove_nopasswd \
    -u sudo_require_authentication \
    -u sudo_require_reauthentication \
    -u sudo_restrict_privilege_elevation_to_authorized \
    -u sysctl_crypto_fips_enabled \
    -u sysctl_fs_protected_fifos \
    -u sysctl_fs_protected_hardlinks \
    -u sysctl_fs_protected_regular \
    -u sysctl_fs_protected_symlinks \
    -u sysctl_fs_suid_dumpable \
    -u sysctl_kernel_core_pattern_empty_string \
    -u sysctl_kernel_core_pattern \
    -u sysctl_kernel_core_uses_pid \
    -u sysctl_kernel_dmesg_restrict \
    -u sysctl_kernel_exec_shield \
    -u sysctl_kernel_kexec_load_disabled \
    -u sysctl_kernel_kptr_restrict \
    -u sysctl_kernel_modules_disabled \
    -u sysctl_kernel_panic_on_oops \
    -u sysctl_kernel_perf_cpu_time_max_percent \
    -u sysctl_kernel_perf_event_max_sample_rate \
    -u sysctl_kernel_perf_event_paranoid \
    -u sysctl_kernel_pid_max \
    -u sysctl_kernel_randomize_va_space \
    -u sysctl_kernel_sysrq \
    -u sysctl_kernel_unprivileged_bpf_disabled_accept_default \
    -u sysctl_kernel_unprivileged_bpf_disabled \
    -u sysctl_kernel_yama_ptrace_scope \
    -u sysctl_net_core_bpf_jit_harden \
    -u sysctl_net_ipv4_conf_all_accept_local \
    -u sysctl_net_ipv4_conf_all_accept_redirects \
    -u sysctl_net_ipv4_conf_all_accept_source_route \
    -u sysctl_net_ipv4_conf_all_arp_filter \
    -u sysctl_net_ipv4_conf_all_arp_ignore \
    -u sysctl_net_ipv4_conf_all_drop_gratuitous_arp \
    -u sysctl_net_ipv4_conf_all_forwarding \
    -u sysctl_net_ipv4_conf_all_log_martians \
    -u sysctl_net_ipv4_conf_all_route_localnet \
    -u sysctl_net_ipv4_conf_all_rp_filter \
    -u sysctl_net_ipv4_conf_all_secure_redirects \
    -u sysctl_net_ipv4_conf_all_send_redirects \
    -u sysctl_net_ipv4_conf_all_shared_media \
    -u sysctl_net_ipv4_conf_default_accept_redirects \
    -u sysctl_net_ipv4_conf_default_accept_source_route \
    -u sysctl_net_ipv4_conf_default_log_martians \
    -u sysctl_net_ipv4_conf_default_rp_filter \
    -u sysctl_net_ipv4_conf_default_secure_redirects \
    -u sysctl_net_ipv4_conf_default_send_redirects \
    -u sysctl_net_ipv4_conf_default_shared_media \
    -u sysctl_net_ipv4_icmp_echo_ignore_broadcasts \
    -u sysctl_net_ipv4_icmp_ignore_bogus_error_responses \
    -u sysctl_net_ipv4_ip_forward \
    -u sysctl_net_ipv4_ip_local_port_range \
    -u sysctl_net_ipv4_tcp_rfc1337 \
    -u sysctl_net_ipv4_tcp_syncookies \
    -u sysctl_net_ipv6_conf_all_accept_ra_defrtr \
    -u sysctl_net_ipv6_conf_all_accept_ra_pinfo \
    -u sysctl_net_ipv6_conf_all_accept_ra_rtr_pref \
    -u sysctl_net_ipv6_conf_all_accept_ra \
    -u sysctl_net_ipv6_conf_all_accept_redirects \
    -u sysctl_net_ipv6_conf_all_accept_source_route \
    -u sysctl_net_ipv6_conf_all_autoconf \
    -u sysctl_net_ipv6_conf_all_forwarding \
    -u sysctl_net_ipv6_conf_all_max_addresses \
    -u sysctl_net_ipv6_conf_all_router_solicitations \
    -u sysctl_net_ipv6_conf_default_accept_ra_defrtr \
    -u sysctl_net_ipv6_conf_default_accept_ra_pinfo \
    -u sysctl_net_ipv6_conf_default_accept_ra_rtr_pref \
    -u sysctl_net_ipv6_conf_default_accept_ra \
    -u sysctl_net_ipv6_conf_default_accept_redirects \
    -u sysctl_net_ipv6_conf_default_accept_source_route \
    -u sysctl_net_ipv6_conf_default_autoconf \
    -u sysctl_net_ipv6_conf_default_max_addresses \
    -u sysctl_net_ipv6_conf_default_router_solicitations \
    -u sysctl_user_max_user_namespaces \
    -u sysctl_vm_mmap_min_addr \
    -u tftpd_uses_secure_mode \
    -u timer_dnf-automatic_enabled \
    -u usbguard_allow_hid_and_hub \
    -u usbguard_generate_policy \
    -u use_kerberos_security_all_exports \
    -u use_pam_wheel_for_su \
    -u use_pam_wheel_group_for_su \
    -u wireless_disable_interfaces \
    -u xwindows_remove_packages \
    -u xwindows_runlevel_target \
    -u zipl_audit_argument \
    -u zipl_audit_backlog_limit_argument \
    -u zipl_bls_entries_only \
    -u zipl_bootmap_is_up_to_date \
    -u zipl_init_on_alloc_argument \
    -u zipl_page_alloc_shuffle_argument \
    -u zipl_systemd_debug-shell_argument_absent \
    -s harden_sshd_ciphers_openssh_conf_crypto_policy \
    -s disable_ctrlaltdel_burstaction \
    -s no_empty_passwords \
    -s sshd_disable_empty_passwords \
    /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml \
    xccdf_org.ssgproject.content_profile_stig