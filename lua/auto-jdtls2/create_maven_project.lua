local function mvn_new_project()
  local function create_notif(message, level)
    local notif_ok, notify = pcall(require, "notify")
    if notif_ok then
      notify(message, level)
    else
      print(message)
    end
  end
  -- Fungsi untuk meminta input dari pengguna dengan opsi untuk membatalkan
  local function get_user_input(prompt, default_value)
    vim.fn.inputsave()
    local result = vim.fn.input(prompt, default_value)
    vim.fn.inputrestore()

    -- Cek apakah pengguna menekan Esc untuk membatalkan input
    if result == "" then
      create_notif("Input canceled.", "info")
      return nil, true
    end

    return result, false
  end
  -- Ambil input dari pengguna untuk menentukan direktori proyek
  local project_dir, canceled = get_user_input("Enter project directory: ", vim.fn.getcwd())
  if canceled then
    return
  end
  -- Buat direktori jika belum ada
  if vim.fn.isdirectory(project_dir) == 0 then
    if vim.fn.mkdir(project_dir, "p") == 0 then
      create_notif("Failed to create project directory: " .. project_dir, "error")
      return
    end
  end
  -- Pindah ke direktori proyek
  -- Hapus satu level dari path
  local parent_dir = vim.fn.fnamemodify(project_dir, ":h")
  local success, err = pcall(vim.fn.chdir, parent_dir)
  if not success then
    create_notif("Error changing directory: " .. err, "error")
    return
  end

  create_notif("Changed directory to: " .. project_dir, "info")
  -- Fungsi untuk mendapatkan nama direktori terakhir dari path
  local function getLastDirName(path)
    local uname = vim.loop.os_uname().sysname
    local name
    if uname == "Windows_NT" then
      name = path:match("([^\\]+)$")
    else
      name = path:match("([^/]+)$")
    end
    return name
  end
  -- Ambil input dari pengguna untuk Maven
  local group_id, canceled_group = get_user_input("Enter groupId: ", "com.example")
  if canceled_group then
    return
  end
  local artifact_id = getLastDirName(project_dir)
  local archetype_artifact_id, canceled_archetype =
    get_user_input("Enter archetypeArtifactId: ", "maven-archetype-quickstart")
  if canceled_archetype then
    return
  end
  local archetype_version, canceled_version = get_user_input("Enter archetypeVersion: ", "1.5")
  if canceled_version then
    return
  end
  local interactive_mode, canceled_interactive = get_user_input("Enter interactiveMode (true/false): ", "false")
  if canceled_interactive then
    return
  end
  -- Format perintah Maven berdasarkan input pengguna
  local command = string.format(
    [[mvn archetype:generate "-DgroupId=%s" "-DartifactId=%s" "-DarchetypeArtifactId=%s" "-DarchetypeVersion=%s" "-DinteractiveMode=%s"]],
    group_id,
    artifact_id,
    archetype_artifact_id,
    archetype_version,
    interactive_mode
  )

  -- Fungsi untuk menjalankan perintah Maven dan menampilkan outputnya
  local function run_maven_command(cmd, project_name)
    local output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      print("Erro ao executar: " .. output)
    else
      local ch_dir = string.format("cd %s", project_name)
      vim.fn.system(ch_dir)
      vim.fn.chdir(project_name)
      -- Cari dan buka file main class
      local uname = vim.loop.os_uname().sysname
      if uname == "Windows_NT" then
        if group_id then
          group_id = group_id:gsub("%.", "\\")
          local main_class_path = string.format("src\\main\\java\\%s\\App.java", group_id)
          if vim.fn.filereadable(main_class_path) == 1 then
            vim.cmd(":edit " .. main_class_path)
          end
        end
      else
        if group_id then
          group_id = group_id:gsub("%.", "/")
          local main_class_path = string.format("src/main/java/%s/App.java", group_id)
          if vim.fn.filereadable(main_class_path) == 1 then
            vim.cmd(":edit " .. main_class_path)
          end
        end
      end
      vim.cmd(":NvimTreeFindFileToggl<CR>")
    end
  end

  -- Jalankan perintah Maven dan buka proyek
  run_maven_command(command, artifact_id)
  create_notif("Project created successfully !", "info")
end

vim.api.nvim_create_user_command("MavenNewProject", mvn_new_project, {})
