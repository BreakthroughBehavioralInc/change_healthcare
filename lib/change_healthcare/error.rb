class ChangeHealthcare::Error < StandardError
  attr_reader :code, :description, :root

  def initialize(xml_root_node)
    @root = xml_root_node
    @code = xml_root_node.children[0].children[0].to_s

    first_children = xml_root_node.children[1]
    @description = first_children.present? ? first_children.children[0].to_s : ""
  end
end
