module TagsHelper
  include ApplicationHelper
  def tags
    tags = []
      tag  = [  ]
      tag.each do |tag|
        tags << Array[tag]
      end
      tags
  end

    def default_tags
      ["transgender", "asked for pronouns", "used my preferred pronouns", "non-binary", "queer", "genderqueer", "trans masculine", "trans feminine", "polyamorous", "asexual", "gay", "lesbian", "sex workers", "bisexual", "pansexual", "latinx", "american indian", "asian", "black", "african american", "middle eastern", "multiracial", "youth", "teen", "adult", "blind or visually impaired", "deaf or hard hearing", "hiv positive", "body positive", "sex positive", "intersex", "other abled", "cognitive disability", "developmental disability","mental health", "in recovery", "survivors of abuse or trauma", "undocumented", "uninsured", "addiction", "people experiencing homelessness", "persons of color", "women", "men", "veterans"]
    end
end
