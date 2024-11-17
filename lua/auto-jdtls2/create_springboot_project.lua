local function create_notif(message, level)
  local notif_ok, notify = pcall(require, "notify")
  if notif_ok then
    notify(message, level)
  else
    print(message)
  end
end

local function safe_request(url)
  local status, request = pcall(function()
    return vim.system({ "curl", "-s", url }, { text = true }):wait()
  end)

  if not status then
    vim.api.nvim_err_writeln("Error making request to " .. url .. ": " .. request)
    return nil
  end

  return request
end

local function safe_json_decode(data)
  local status, decoded = pcall(vim.fn.json_decode, data)

  if not status then
    vim.api.nvim_err_writeln("Error decoding JSON: " .. decoded)
    return nil
  end

  return decoded
end

local function contains(list, element)
  for _, value in pairs(list) do
    if value == element then
      return true
    end
  end
  return false
end

local function list_to_string(list, is_err)
  local result = ""

  for i, value in ipairs(list) do
    if is_err then
      result = result .. "'" .. tostring(value) .. "'"
    else
      result = result .. tostring(value)
    end
    if i < #list then
      if is_err then
        result = result .. " or "
      else
        result = result .. "/"
      end
    end
  end
  return result
end

local function handle_start_springboot_data(data)
  local spring_data = {}
  for _, value in pairs(data.values) do
    table.insert(spring_data, value.id)
  end
  return spring_data
end

local function change_directory()
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
  local success, err = pcall(vim.fn.chdir, project_dir)
  if not success then
    create_notif("Error changing directory: " .. err, "error")
    return
  end

  create_notif("Changed directory to: " .. project_dir, "info")
  return project_dir
end

local function get_build_type(data_available)
  local build_type_available = list_to_string(data_available, false)
  local options_err = list_to_string(data_available, true)
  local build_type = vim.fn.input("Enter build type (" .. build_type_available .. "): ", "maven")
  if not contains(data_available, build_type) then
    create_notif("Invalid build type. Please enter " .. options_err .. ".", "info")
    return ""
  end

  return build_type
end

local function get_language(data_available)
  local language_available = list_to_string(data_available, false)
  local options_err = list_to_string(data_available, true)

  local language = vim.fn.input("Enter Language (" .. language_available .. "): ", "java")
  if not contains(data_available, language) then
    create_notif("Invalid language. Please enter " .. options_err .. ".", "info")
    return ""
  end

  return language
end

local function get_java_version(data_available)
  local version_available = list_to_string(data_available, false)
  local options_err = list_to_string(data_available, true)

  local java_version = vim.fn.input("Enter Java Version (" .. version_available .. "): ", "21")
  if not contains(data_available, java_version) then
    create_notif("Invalid Java version. Please enter a valid version " .. options_err .. ".", "info")
    return ""
  end

  return java_version
end

local function get_boot_version(data_available)
  local version_available = list_to_string(data_available, false)
  local options_err = list_to_string(data_available, true)

  local versions_table = {}
  for v in string.gmatch(version_available, "([^/]+)") do
    table.insert(versions_table, "-> " .. v)
  end
  local annotated_versions = table.concat(versions_table, "\n")
  local boot_version = vim.fn.input(annotated_versions .. "\n: ", "3.3.5.RELEASE")
  if not contains(data_available, boot_version) then
    create_notif("Invalid Spring Boot version. Please enter a valid version " .. options_err .. ".", "info")
    return ""
  end

  return boot_version
end

local function get_packaging(data_available)
  local packaging_available = list_to_string(data_available, false)
  local options_err = list_to_string(data_available, true)

  local packaging = vim.fn.input("Enter Packaging(" .. packaging_available .. "): ", "jar")
  if packaging ~= "jar" and packaging ~= "war" then
    create_notif("Invalid packaging. Please enter " .. options_err .. ".", "info")
    return ""
  end
  return packaging
end

local function springboot_new_project()
  local request = safe_request("https://start.spring.io/metadata/client")

  if not request then
    vim.api.nvim_err_writeln("Failed to make a request to the URL.")
    return false
  end

  local springboot_data = safe_json_decode(request.stdout)

  if not springboot_data then
    vim.api.nvim_err_writeln("Failed to decode JSON from the request.")
    return false
  end
  local project_dir = change_directory()
  local build_types = { "maven", "gradle" }
  local languages = handle_start_springboot_data(springboot_data.language)
  local java_versions = handle_start_springboot_data(springboot_data.javaVersion)
  local boot_versions = handle_start_springboot_data(springboot_data.bootVersion)
  local packagings = handle_start_springboot_data(springboot_data.packaging)
  local build_type = get_build_type(build_types)

  if build_type:len() == 0 then
    return
  end

  local language = get_language(languages)
  if language:len() == 0 then
    return
  end

  local java_version = get_java_version(java_versions)
  if java_version:len() == 0 then
    return
  end

  local boot_version = get_boot_version(boot_versions)
  if boot_version:len() == 0 then
    return
  end

  local packaging = get_packaging(packagings)
  if packaging:len() == 0 then
    return
  end

  local dependencies = vim.fn.input("Enter dependencies (comma separated): ", "devtools,web,data-jpa,h2,thymeleaf")
  local group_id = vim.fn.input("Enter Group ID: ", "com.example")
  local artifact_id = vim.fn.input("Enter Artifact ID: ", "myproject")
  local name = vim.fn.input("Enter project name: ", artifact_id)
  local package_name = vim.fn.input("Enter package name: ", group_id .. "." .. artifact_id)
  local description = vim.fn.input("Enter project description: ", "")

  local command = string.format(
    "spring init --boot-version=%s --java-version=%s --dependencies=%s --groupId=%s --artifactId=%s --name=%s --package-name=%s --description=%s --language=%s --build=%s %s",
    boot_version,
    java_version,
    dependencies,
    group_id,
    artifact_id,
    name,
    package_name,
    description, -- Menambahkan deskripsi proyek
    language, -- Menambahkan bahasa pemrograman (Java, Kotlin, atau Groovy)
    build_type,
    name
  )

  -- Fungsi untuk mengubah teks
  local function capitalize_first_letter(str)
    return str:sub(1, 1):upper() .. str:sub(2):lower()
  end

  local output = vim.fn.system(command)
  if vim.v.shell_error ~= 0 then
    create_notif("Erro ao executar: " .. output, "error")
  else
    local ch_dir = string.format("cd %s", project_dir .. "/" .. name)
    vim.fn.system(ch_dir)
    vim.fn.chdir(project_dir .. "/" .. name)
    create_notif(name, "info")
    -- Cari dan buka file main class
    local uname = vim.loop.os_uname().sysname
    local pth = package_name
    if uname == "Windows_NT" then
      if pth then
        pth = pth:gsub("%.", "\\")
        create_notif(pth, "info")
        local main_class_path =
          string.format("src\\main\\java\\%s\\" .. capitalize_first_letter(name) .. "Application.java", pth)
        create_notif(main_class_path, "info")
        if vim.fn.filereadable(main_class_path) == 1 then
          vim.cmd(":edit " .. main_class_path)
        end
      end
    else
      if pth then
        pth = pth:gsub("%.", "/")
        local main_class_path =
          string.format("src/main/java/%s/" .. capitalize_first_letter(name) .. "Application.java", pth)
        if vim.fn.filereadable(main_class_path) == 1 then
          vim.cmd(":edit " .. main_class_path)
        end
      end
    end
    vim.cmd(":NvimTreeFindFileToggl<CR>")
  end

  create_notif("Project created successfully!", "info")
end

vim.api.nvim_create_user_command("SpringBootNewProject", springboot_new_project, {})
