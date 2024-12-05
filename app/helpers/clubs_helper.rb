module ClubsHelper
  def club_logo(club)
    if club.logo.attached?
      cl_image_tag club.logo.key, transformation: { width: 100, height: 100, crop: :fill }
    else
      image_tag 'default_logo.png', width: 100, height: 100, alt: 'Default Logo'
    end
  end

  def club_header_img(club)
    if club.header_img.attached?
      cl_image_tag club.header_img.key, transformation: { width: 800, height: 400, crop: :fill, gravity: :center }
    else
      image_tag 'default_header_img.png', width: 800, height: 400, crop: :fill, gravity: :center, alt: 'header image'
    end
  end
end
