local function gradle_new_project()
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

  -- Ambil input dari pengguna untuk Gradle
  local project_name, canceled_name = get_user_input("Enter project name: ", "myjavaproject")
  if canceled_name then
    return
  end

  project_dir = project_dir .. "\\" .. project_name

  -- Buat direktori jika belum ada
  if vim.fn.isdirectory(project_dir) == 0 then
    if vim.fn.mkdir(project_dir, "p") == 0 then
      create_notif("Failed to create project directory: " .. project_dir, "error")
      return
    end
  end
  -- Pindah ke direktori proyek
  local success, err = pcall(vim.fn.chdir, project_dir)
  if not success then
    create_notif("Error changing directory: " .. err, "error")
    return
  end

  create_notif("Changed directory to: " .. project_dir, "info")

  -- Ambil input package name
  local package_name, canceled_package = get_user_input("Enter package name: ", "com.example." .. project_name)
  if canceled_package then
    return
  end

  -- Format perintah Gradle berdasarkan input pengguna
  local command = string.format(
    "gradle init --type java-application --dsl groovy --project-name %s --package %s",
    project_name,
    package_name
  )

  -- Fungsi untuk menjalankan perintah Gradle dan menampilkan outputnya
  local function run_gradle_command(cmd, dir, pkg)
    local output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      create_notif("Error executing: " .. output, "error")
    else
      create_notif("Project created successfully!", "info")
      local main_class_path = string.format("%s/app/src/main/java/%s/App.java", dir, pkg:gsub("%.", "/"))
      if vim.fn.filereadable(main_class_path) == 1 then
        vim.cmd(":edit " .. main_class_path)
      end
      vim.cmd(":NvimTreeFindFileToggle<CR>")
    end
  end

  -- Jalankan perintah Gradle dan buka proyek
  run_gradle_command(command, project_dir, package_name)
end

vim.api.nvim_create_user_command("GradleNewProject", gradle_new_project, {})
