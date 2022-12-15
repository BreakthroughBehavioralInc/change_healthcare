class ChangeHealthcare::Error < StandardError
  attr_reader :code, :description, :root

  def initialize(xml_root_node)
    @root = xml_root_node
    root_children = xml_root_node.children
    @code = root_children[0].present? ? root_children[0].children[0].to_s : ""
    @description = root_children[1].present? ? root_children[1].children[1].to_s : ""
  end
end
