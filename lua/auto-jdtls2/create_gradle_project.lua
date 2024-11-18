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
  -- Ambil input Testing
  local test, canceled_test = get_user_input("Testing (junit,junit-jupiter,testng,spock): ", "junit-jupiter")
  if canceled_test then
    return
  end
  -- Ambil input DSL
  local script_dsl, canceled_dsl = get_user_input("Script DSL (kotlin, groovy): ", "groovy")
  if canceled_dsl then
    return
  end
  -- Ambil input package name
  local package_name, canceled_package = get_user_input("Enter package name: ", "com.example")
  if canceled_package then
    return
  end

  -- Format perintah Gradle berdasarkan input pengguna
  local command = string.format(
    "echo no | gradle init --type java-application --test-framework %s  --dsl %s --package %s --no-daemon",
    test,
    script_dsl,
    package_name
  )

  -- Fungsi untuk menjalankan perintah Gradle dan menampilkan outputnya
  local function run_gradle_command(cmd, path, pkg)
    local output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      create_notif("Error executing: " .. output, "error")
    else
      create_notif("Project created successfully!", "info")
      create_notif("Please Reopen Dir : " .. path, "info")
      vim.cmd(":NvimTreeFindFileToggle<CR>")
      local main_class_path = string.format("%s/app/src/main/java/%s/App.java", path, pkg:gsub("%.", "/"))
      if vim.fn.filereadable(main_class_path) == 1 then
        vim.cmd(":edit " .. main_class_path)
      end
      local function delayed_quit()
        vim.defer_fn(function()
          vim.cmd("qa!")
        end, 4000) -- Delay is set in milliseconds (3,000ms = 3 seconds)
      end
      -- Run the delayed quit function
      delayed_quit()
    end
  end

  -- Jalankan perintah Gradle dan buka proyek
  run_gradle_command(command, vim.fn.getcwd(), package_name)
end

vim.api.nvim_create_user_command("GradleNewProject", gradle_new_project, {})
