local function create_java_main_class()
  local function create_notif(message, level)
    local notif_ok, notify = pcall(require, "notify")
    if notif_ok then
      notify(message, level)
    else
      print(message)
    end
  end

  local is_maven_project = function()
    if vim.fn.findfile("pom.xml", vim.fn.getcwd()) == "pom.xml" then
      return true
    else
      return false
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

  -- Fungsi untuk mendapatkan nama package default berdasarkan buffer aktif
  local function get_default_package()
    local path = vim.fn.expand("%:p:h")
    local project_root = vim.fn.getcwd()
    local relative_path = path:sub(#project_root + 1)
    relative_path = relative_path:gsub("app\\src\\main\\java\\", "")
    relative_path = relative_path:gsub("src\\main\\java\\", "")
    relative_path = relative_path:gsub("app/src/main/java/", "")
    relative_path = relative_path:gsub("src/main/java/", "")
    relative_path = relative_path:gsub("\\", ".")
    relative_path = relative_path:gsub("/", ".")
    return relative_path:sub(2)
  end

  -- Ambil input dari pengguna untuk nama package dan nama kelas
  local package_name, canceled_package = get_user_input("Enter package name: ", get_default_package())
  if canceled_package then
    return
  end

  local class_name, canceled_class = get_user_input("Enter class name: ", "MyMainClass")
  if canceled_class then
    return
  end

  -- Format direktori dan path file berdasarkan input pengguna
  local package_dir = nil
  if package_name then
    if is_maven_project() then
      package_dir = string.format("src/main/java/%s", package_name:gsub("%.", "/"))
    else
      package_dir = string.format("app/src/main/java/%s", package_name:gsub("%.", "/"))
    end
    if vim.fn.isdirectory(package_dir) == 0 then
      vim.fn.mkdir(package_dir, "p")
    end
  else
    create_notif("Invalid package name: " .. package_name, "error")
    return
  end

  local file_path = string.format("%s/%s.java", package_dir, class_name)
  if vim.fn.filereadable(file_path) == 1 then
    create_notif("Class already exists: " .. file_path, "error")
    return
  end

  -- Tulis konten kelas Java ke dalam file
  local class_content = string.format(
    [[
/*
 * This Java source file.
 */
package %s;

public class %s {
    /**
     * 
     */
    public static void main(String[] args) {
        System.out.println("Hello World");
    }

}
]],
    package_name,
    class_name,
    class_name
  )

  local file = io.open(file_path, "w")
  if file then
    file:write(class_content)
    file:close()
  end

  -- Buka file Java yang baru dibuat di Neovim
  vim.cmd(":edit " .. file_path)
  create_notif("Java class created: " .. file_path, "info")
end

vim.api.nvim_create_user_command("CreateJavaMainClass", create_java_main_class, {})
