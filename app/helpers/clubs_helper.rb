module ClubsHelper
  def club_logo(club)
    if club.logo.attached?
      cl_image_tag club.logo.key, transformation: { width: 100, height: 100, crop: :fill }
    else
      image_tag 'default_logo.png', width: 100, height: 100, alt: 'Default Logo'
    end
  end
end
