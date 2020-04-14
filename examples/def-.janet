# In a file module.janet
(def- private-thing :encapsulated)
(def public-thing :exposed)

# In a file main.janet
(import module)

module/private-thing # -> Unknown symbol
module/public-thing # -> :exposed

# Same as normal def with :private metadata
(def :private x private-thing :encapsulated)
